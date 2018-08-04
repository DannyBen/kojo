module Kojo
  class Template
    attr_reader :file, :extension, :args, :dir
    attr_accessor :import_base

    def initialize(file, args={})
      @file = file
      @args = args
      @extension = file[/(\..*)$/]
      @dir = File.dirname file
      @import_base = dir
    end

    def render
      evaluate file, args
    end

    private

    def import(file, import_args={})
      filename = File.expand_path "#{file}#{extension}", import_base
      all_args = args.merge import_args
      self.class.new(filename, all_args).render
    end

    def evaluate(file, args={})
      content = File.read(file) % args
      result = []
      
      content.lines.each do |line|
        line.chomp!
        spaces = line[/^\s*/].size

        if line =~ /@import ([^(\s]*)\s*(?:\((.*)\))?\s*/
          file = $1
          args = $2 || ''
          args = instance_eval("{#{args}}")
          imported = import file, args
          line = indent imported, spaces
        end
        
        result.push line
      end
      result.join "\n"
    end

    def indent(text, spaces)
      text.lines.collect { |line| "#{' ' * spaces}#{line}" }.join
    end
  end

end