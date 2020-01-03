require 'yaml'

module Kojo
  # The Config class handles multiple template generation from a 
  # definitions YAML file.
  class Config
    using Refinements

    attr_reader :config_file, :outdir
    attr_accessor :import_base

    def initialize(config_file)
      @config_file = config_file
      @import_base = nil
    end

    def generate(opts={}, &block)
      if directory_mode?
        generate_from_dir opts, &block
      else
        generate_from_file opts, &block
      end
    end

  private

    def generate_from_file(opts)
      config['output'].each do |target, config_opts|
        local_opts = opts.merge config_opts.symbolize_keys
        
        template = Template.new source
        template.import_base = import_base if import_base
        
        yield target, template.render(local_opts)
      end
    end

    def generate_from_dir(opts)
      config['output'].each do |dir, config_opts|
        local_opts = opts.merge config_opts.symbolize_keys

        collection = Collection.new source
        collection.import_base = import_base if import_base

        collection.render(local_opts) do |file, output|
          yield "#{dir}/#{file}", output
        end
      end
    end

    def base_dir
      @base_dir ||= File.dirname config_file
    end

    def directory_mode?
      File.directory? source
    end

    def source
      "#{base_dir}/#{config['input']}"
    end

    def config
      @config ||= YAML.load_file config_file
    end
  end

end
