require 'kojo'

help "Compile a file from a template"

usage "kojo file INFILE [--save FILE] [ARGS...]"
usage "kojo file (-h|--help)"

option "-s --save FILE", "Save to file instead of printing"

param "ARGS", "Optional key=value pairs"

example "kojo file main.yml"
example "kojo file main.yml --save out.yml"
example "kojo file main.yml -s out.yml app=lause"

action do |args|
  opts = args['ARGS'].args_to_hash
  outfile = args['--save']
  infile = args['INFILE']

  output = Kojo::Template.new(infile, opts).render

  if outfile
    File.write outfile, output
    say "Saved #{outfile}"
  else
    puts output
  end
end

