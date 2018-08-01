require 'kojo'

help "Generate a file from a template"

usage "kojo generate INFILE [--save FILE] [ARGS...]"
usage "kojo generate (-h|--help)"

option "-s --save FILE", "Save to file instead of printing"

param "ARGS", "Optional key=value pairs"

example "kojo generate main.yml"
example "kojo generate main.yml --save out.yml"
example "kojo generate main.yml -s out.yml app=lause"

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

