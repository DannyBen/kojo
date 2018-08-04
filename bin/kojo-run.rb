require 'kojo'
require 'fileutils'

help "Run and process a config file"

usage "kojo run CONFIG [--save DIR] [ARGS...]"
usage "kojo run (-h|--help)"

option "-s --save DIR", "Save output to directory instead of printing"

param "ARGS", "Optional key=value pairs"

example "kojo run config.yml"
example "kojo run config.yml --save output"
example "kojo run config.yml -s output scale=3"

action do |args|
  gen = Kojo::Generator.new args['CONFIG']
  outdir = args['--save']
  
  if outdir and !Dir.exist? outdir
    FileUtils.mkdir_p outdir
  end

  gen.generate do |file, output|
    path = "#{outdir}/#{file}"
    if outdir
      File.write path, output
      say "Saved #{path}"
    else
      say "\n!txtgrn!# #{file}"
      say output
    end
  end
end

