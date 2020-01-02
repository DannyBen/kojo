require 'mister_bin'

module Kojo::Commands
  # Handle calls to the +kojo file+ command
  class FileCmd < MisterBin::Command
    using Kojo::Refinements

    attr_reader :opts, :outfile, :infile, :import_base

    help "Transform a file from a template"

    usage "kojo file INFILE [--save FILE --imports DIR --args FILE] [ARGS...]"
    usage "kojo file (-h|--help)"

    option "-s --save FILE", "Save to file instead of printing"
    option "-i --imports DIR", "Specify base directory for @import directives"
    option "-a --args FILE", "Load arguments from YAML file"

    param "INFILE", "Template to transform"
    param "ARGS", "Optional key=value pairs"

    example "kojo file main.yml"
    example "kojo file main.yml --save out.yml"
    example "kojo file main.yml -s out.yml app=lause"
    example "kojo file main.yml -s out.yml --args args.yml"

    def run
      @opts = args['ARGS'].args_to_hash
      @outfile = args['--save']
      @infile = args['INFILE']
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
      template = Kojo::Template.new infile
      template.import_base = import_base if import_base
      output = template.render(opts)

      if outfile
        File.write outfile, output
        say "Saved #{outfile}"
      else
        puts output
      end
    end

  end
end
