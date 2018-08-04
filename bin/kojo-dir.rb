require 'kojo'

help "Compile a folder of templates to a similar output folder"

usage "kojo dir INDIR [--save DIR --import DIR] [ARGS...]"
usage "kojo dir (-h|--help)"

option "-s --save DIR", "Save output to directory instead of printing"
option "-i --import DIR", "Specify base directory for @import directives"

param "ARGS", "Optional key=value pairs"

example "kojo dir indir"
example "kojo dir in --save out env=production"
example "kojo dir in --save out --import snippets env=production"

action do |args|
  opts = args['ARGS'].args_to_hash
  indir = args['INDIR']
  outdir = args['--save']
  import_base = args['--import']

  files = Dir["#{indir}/**/*"].reject { |file| File.directory? file }

  files.each do |file|
    template = Kojo::Template.new(file, opts)
    template.import_base = import_base if import_base
    output = template.render

    if outdir
      outpath = file.sub(/#{indir}/, outdir)
      
      dir = File.dirname outpath
      FileUtils.mkdir_p dir unless Dir.exist? dir

      File.write outpath, output
      say "Saved #{outpath}"  
    else
      outpath = file.sub(/#{indir}/, '')
      say "\n!txtgrn!# #{outpath}"
      say output
    end
  end
end

