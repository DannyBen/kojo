require 'mister_bin'

module Kojo
  module Commands
    class CommandBase < MisterBin::Command
      def save(file, output)
        File.deep_write file, output
        say "Saved #{file}"
      end
    end
  end
end