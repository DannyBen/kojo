require 'mister_bin'

module Kojo::Commands
  class DirCmd < MisterBin::Command
    attr_reader :opts, :indir, :outdir, :import_base

    help "Compile a folder of templates to a similar output folder"

    usage "kojo dir INDIR [--save DIR --import DIR --args FILE] [ARGS...]"
    usage "kojo dir (-h|--help)"

    option "-s --save DIR", "Save output to directory instead of printing"
    option "-i --import DIR", "Specify base directory for @import directives"
    option "-a --args FILE", "Load arguments from YAML file"

    param "ARGS", "Optional key=value pairs"

    example "kojo dir indir"
    example "kojo dir in --save out env=production"
    example "kojo dir in --save out --import snippets env=production"
    example "kojo dir in -s out -i snippets -a args.yml"

    def run(args)
      @opts = args['ARGS'].args_to_hash
      @indir = args['INDIR']
      @outdir = args['--save']
      @import_base = args['--import']
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
        save file, output
      end
    end

    def save(file, output)
      outpath = "#{outdir}/#{file}"
      dir = File.dirname outpath
      FileUtils.mkdir_p dir unless Dir.exist? dir
      File.write outpath, output
      say "Saved #{outpath}"  
    end
  end
end
