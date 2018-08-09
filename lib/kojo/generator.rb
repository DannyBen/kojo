require 'yaml'

module Kojo
  # The Generator class handles multiple template generation from a 
  # definitions YAML file.
  class Generator
    attr_reader :config_file, :outdir

    def initialize(config_file)
      @config_file = config_file
    end

    def generate(opts={})
      base_dir = File.dirname config_file
      infile = "#{base_dir}/#{config['input']}"

      config['output'].each do |outfile, config_opts|      
        local_opts = opts.merge config_opts.symbolize_keys
        output = render infile, local_opts
        yield outfile, output
      end
    end
    
    private

    def config
      @config ||= YAML.load_file config_file
    end

    def render(infile, opts={})
      Template.new(infile).render(opts)
    end
  end

end
