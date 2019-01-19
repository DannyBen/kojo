require 'fileutils'
require 'mister_bin'

module Kojo::Commands
  # Handle calls to the +kojo config+ command
  class ConfigCmd < MisterBin::Command
    attr_reader :gen, :outdir, :opts, :import_base, :config_file

    help "Transform based on instructions from a config file"

    usage "kojo config CONFIG [--save DIR --imports DIR --args FILE] [ARGS...]"
    usage "kojo config (-h|--help)"

    option "-s --save DIR", "Save output to directory instead of printing"
    option "-i --imports DIR", "Specify base directory for @import directives"
    option "-a --args FILE", "Load arguments from YAML file"

    param "CONFIG", "YAML configuration file"
    param "ARGS", "Optional key=value pairs"

    example "kojo config config.yml"
    example "kojo config config.yml --save output"
    example "kojo config config.yml -s output scale=3"
    example "kojo config config.yml -s output --args args.yml"

    def run
      @config_file = args['CONFIG']
      @outdir = args['--save']
      @opts = args['ARGS'].args_to_hash
      @import_base = args['--imports']
      argfile = args['--args']

      if argfile
        fileopts = YAML.load_file(argfile).symbolize_keys
        @opts = fileopts.merge opts
      end

      run!
    end

  private

    def run!
      config = Kojo::Config.new config_file
      config.import_base = import_base if import_base

      config.generate opts do |file, output|
        handle file, output
      end
    end

    def handle(file, output)
      if outdir
        save "#{outdir}/#{file}", output
      else
        say "\n!txtgrn!# #{file}"
        say output
      end
    end

    def save(path, output)
      dir = File.dirname path
      FileUtils.mkdir_p dir unless Dir.exist? dir
      File.write path, output
      say "Saved #{path}"
    end

  end
end
