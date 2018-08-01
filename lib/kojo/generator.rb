require 'yaml'

module Kojo
  class Generator
    attr_reader :config_file, :outdir

    def initialize(config_file)
      @config_file = config_file
    end

    def generate(opts={})
      base_dir = File.dirname config_file
      infile = "#{base_dir}/#{config['input']}"

      result = []

      config['output'].each do |outfile, opts|      
        output = render infile, opts.symbolize_keys
        if block_given?
          yield outfile, output
        else
          result << "\n# #{outfile}\n#{output}"
        end
      end

      result.empty? ? nil : result.join("\n")
    end
    
    private

    def config
      @config ||= YAML.load_file config_file
    end

    def render(infile, opts={})
      Template.new(infile, opts).render
    end
  end

end
