require 'kojo'
require 'fileutils'

help "Generate based on instructions from a config file"

usage "kojo config CONFIG [--save DIR] [ARGS...]"
usage "kojo config (-h|--help)"

option "-s --save DIR", "Save output to directory instead of printing"

param "ARGS", "Optional key=value pairs"

example "kojo config config.yml"
example "kojo config config.yml --save output"
example "kojo config config.yml -s output scale=3"

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

