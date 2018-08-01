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
  
  if outdir
    FileUtils.mkdir_p outdir unless Dir.exist? outdir

    gen.generate do |file, output|
      path = "#{outdir}/#{file}"
      File.write path, output
      say "Saved #{path}"
    end
  
  else
    puts gen.generate
  
  end
end

