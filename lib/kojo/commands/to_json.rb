require 'mister_bin'

module Kojo
  module Commands
    # Handle calls to the +kojo dir+ command
    class ToJsonCmd < CommandBase
      using Kojo::Refinements

      attr_reader :input, :save_files, :replace_files

      help 'Convert one or more YAML files to JSON'

      usage 'kojo tojson INPUT... [(--save | --replace)]'
      usage 'kojo tojson (-h|--help)'

      option '-s --save', 'Save each input file in the same directory'
      option '-r --replace', 'Save each input file in the same directory and delete the input file'

      param 'INPUT', 'Path to a YAML file or multiple files using a glob pattern'

      example 'kojo tojson myfile.yaml'
      example 'kojo tojson myfile.yaml --save'
      example 'kojo tojson indir/*.yaml'
      example 'kojo tojson indir/*.yaml --replace'
      example 'kojo tojson indir/**/*.yml'

      def run
        @input = input_files
        @save_files = args['--save'] || args['--replace']
        @replace_files = args['--replace']

        save_files ? write : show
      end

    private

      def tojson(path)
        JSON.pretty_generate YAML.load_file(path)
      end

      # Glob patterns are usually handled by the shell, but in case
      # we still have '*' in our string (for example, if it was sent
      # quoted), we will do the globbing ourselves
      def input_files
        args['INPUT'].map do |path|
          path.include?('*') ? Dir[path].sort : path
        end.flatten
      end

      def show
        input.each do |infile|
          outfile = infile.gsub(/\.ya?ml/, '.json')
          say "\n!txtgrn!# #{outfile}"
          say tojson(infile)
        end
      end

      def write
        input.each do |infile|
          outfile = infile.gsub(/\.ya?ml/, '.json')
          save outfile, tojson(infile)
          File.delete infile if replace_files
        end
      end
    end
  end
end
