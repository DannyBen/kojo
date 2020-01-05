require 'mister_bin'

module Kojo
  module Commands
    # Handle calls to the +kojo single+ command
    class SingleCmd < CommandBase
      using Kojo::Refinements

      attr_reader :opts, :infile, :outdir

      help "Transform using a single file that contains the instructions"

      usage "kojo single INFILE [--save DIR] [ARGS...]"
      usage "kojo single (-h|--help)"

      option "-s --save DIR", "Save output to directory instead of printing"

      param "INFILE", "Template to transform. The template should contain a YAML front matter with transformation instructions"
      param "ARGS", "Optional key=value pairs"

      example "kojo single Dockerfile"
      example "kojo single template.Dockerfile --save ."
      example "kojo single template.Dockerfile --save output"
      example "kojo single template.Dockerfile scale=2"

      def run
        @opts = args['ARGS'].args_to_hash
        @outdir = args['--save']
        @infile = args['INFILE']
        run!
      end

    private

      def run!
        template = Kojo::FrontMatterTemplate.new infile
        outdir ? write(template) : show(template)
      end

      def show(template)
        template.render opts do |file, output|
          say "\n!txtgrn!# #{file}"
          say output
        end
      end

      def write(template)
        template.render opts do |file, output|
          save file, output
        end
      end
    end
  end
end