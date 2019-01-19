require 'mister_bin'

module Kojo::Commands
  class CommandBase < MisterBin::Command
    def save(file, output)
      outpath = "#{outdir}/#{file}"
      dir = File.dirname outpath
      FileUtils.mkdir_p dir unless Dir.exist? dir
      File.write outpath, output
      say "Saved #{outpath}"  
    end
  end
end
