require 'mister_bin'

module Kojo
  class CLI
    def self.runner
      runner = MisterBin::Runner.new version: Kojo::VERSION

      runner.route 'file',   to: Kojo::Commands::FileCmd
      runner.route 'dir',    to: Kojo::Commands::DirCmd
      runner.route 'config', to: Kojo::Commands::ConfigCmd

      runner
    end
  end

end
