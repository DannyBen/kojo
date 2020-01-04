require 'mister_bin'

module Kojo
  module Commands
    class CommandBase < MisterBin::Command
      def save(file, output)
        outpath = "#{outdir}/#{file}"
        File.deep_write outpath, output
        say "Saved #{outpath}"  
      end
    end
  end
end