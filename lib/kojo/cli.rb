require 'mister_bin'
requires 'commands'

module Kojo
  # The CLI class is used by the kojo binary and forwards incoming CLI 
  # commands to the relevant Kojo::Commands class
  class CLI
    def self.runner
      runner = MisterBin::Runner.new version: Kojo::VERSION

      runner.route 'file',   to: Kojo::Commands::FileCmd
      runner.route 'dir',    to: Kojo::Commands::DirCmd
      runner.route 'config', to: Kojo::Commands::ConfigCmd
      runner.route 'single', to: Kojo::Commands::SingleCmd

      runner
    end
  end

end
