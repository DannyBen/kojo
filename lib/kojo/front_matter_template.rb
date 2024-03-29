module Kojo
  # The FrontMatterTemplate class handles a single template file, that
  # contains a YAML front matter.
  class FrontMatterTemplate
    using Refinements

    attr_reader :file, :args, :template

    def initialize(file)
      @file = file
    end

    def render(additional_args = nil)
      additional_args ||= {}
      config, @template = read_file file

      config.each do |outfile, args|
        content = handle args.merge(additional_args)
        yield outfile, content
      end
    end

  private

    def handle(args = {})
      template.eval_erb(args, file).eval_vars(args, file)
    end

    def read_file(file)
      raise Kojo::NotFoundError, "File not found: #{file}" unless File.exist? file

      config = YAML.load_file file
      content = File.read(file)[/^---\s*$\n(.*)/m, 1]

      [config, content]
    end
  end
end
