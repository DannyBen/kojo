module Kojo
  class Collection
    attr_reader :dir
    attr_accessor :import_base

    def initialize(dir)
      @dir = dir
      @import_base = dir
    end

    def render(args={}, &block)
      files.each do |file|
        handle file, args, &block
      end
    end

    private

    def handle(file, args={})
      template = Template.new file
      template.import_base = import_base

      path = file.sub(/#{dir}\//, '')
      
      yield path, template.render(args)
    end

    def files
      @files ||= Dir["#{dir}/**/*"].reject { |f| File.directory? f }
    end
  end
end
