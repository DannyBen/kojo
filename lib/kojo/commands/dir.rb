require 'mister_bin'

module Kojo
  module Commands
    # Handle calls to the +kojo dir+ command
    class DirCmd < CommandBase
      using Kojo::Refinements

      attr_reader :opts, :indir, :outdir, :import_base

      help 'Transform a folder of templates to a similar output folder'

      usage 'kojo dir INDIR [--save DIR --imports DIR --args FILE] [ARGS...]'
      usage 'kojo dir (-h|--help)'

      option '-s --save DIR', 'Save output to directory instead of printing'
      option '-i --imports DIR', 'Specify base directory for @import directives'
      option '-a --args FILE', 'Load arguments from YAML file'

      param 'INDIR', 'Directory containing templates to transform'
      param 'ARGS', 'Optional key=value pairs'

      example 'kojo dir indir'
      example 'kojo dir in --save out env=production'
      example 'kojo dir in --save out --imports snippets env=production'
      example 'kojo dir in -s out -i snippets -a args.yml'

      def run
        @opts = args['ARGS'].args_to_hash
        @indir = args['INDIR']
        @outdir = args['--save']
        @import_base = args['--imports']
        argfile = args['--args']

        if argfile
          fileopts = YAML.load_file(argfile).symbolize_keys
          @opts = fileopts.merge @opts
        end

        run!
      end

    private

      def run!
        collection = Kojo::Collection.new @indir
        collection.import_base = import_base if import_base

        if outdir
          write collection
        else
          show collection
        end
      end

      def show(collection)
        collection.render @opts do |file, output|
          say "\n!txtgrn!# #{file}"
          say output
        end
      end

      def write(collection)
        collection.render @opts do |file, output|
          save "#{outdir}/#{file}", output
        end
      end
    end
  end
end
