require 'kojo'
require 'fileutils'

help "Generate based on instructions from a config file"

usage "kojo config CONFIG [--save DIR --args FILE] [ARGS...]"
usage "kojo config (-h|--help)"

option "-s --save DIR", "Save output to directory instead of printing"
option "-a --args FILE", "Load arguments from YAML file"

param "ARGS", "Optional key=value pairs"

example "kojo config config.yml"
example "kojo config config.yml --save output"
example "kojo config config.yml -s output scale=3"
example "kojo config config.yml -s output --args args.yml"

action do |args|
  gen = Kojo::Generator.new args['CONFIG']
  outdir = args['--save']
  opts = args['ARGS'].args_to_hash
  argfile = args['--args']

  if argfile
    fileopts = YAML.load_file(argfile).symbolize_keys
    opts = fileopts.merge opts
  end

  gen.generate opts do |file, output|
    path = "#{outdir}/#{file}"
    if outdir
      dir = File.dirname path
      FileUtils.mkdir_p dir unless Dir.exist? dir

      File.write path, output
      say "Saved #{path}"
    else
      say "\n!txtgrn!# #{file}"
      say output
    end
  end
end

