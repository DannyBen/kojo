module Kojo
  # The Collection class is a wrapper around the {Template} object. It 
  # provides a mechanism for processing an entire directory of templates.
  class Collection
    using Refinements

    attr_reader :dir
    attr_accessor :import_base

    def initialize(dir)
      @dir = dir
      @import_base = dir
    end

    def render(args = {}, &block)
      files.each do |file|
        handle file, args, &block
      end
    end

    def size
      files.size
    end

  private

    def handle(file, args = {})
      template = Template.new file
      template.import_base = import_base

      path = file.sub(/#{dir}\//, '').resolve args

      yield path, template.render(args)
    end

    def files
      return @files if @files
      raise Kojo::NotFoundError, "Directory not found: #{dir}" unless Dir.exist? dir
      raise Kojo::NotFoundError, "Directory is empty: #{dir}" if Dir.empty? dir

      @files = Dir["#{dir}/**/*"].reject { |f| File.directory? f }.sort
    end
  end
end
