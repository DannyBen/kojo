module Kojo
  # The Template class handles a single template file, and processes it for:
  # - Variables (using +%{var}+ syntax)
  # - ERB
  # - +@import+ statements
  class Template
    using Refinements

    attr_reader :file, :extension, :dir, :args
    attr_accessor :import_base

    def initialize(file)
      @file = file
      @extension = File.extname file
      @dir = File.dirname file
      @import_base = dir
    end

    def render(args = {})
      @args = args
      evaluate file
    end

  protected

    def evaluate(file)
      content = read_file file
      content = content.eval_erb args, file
      content = content.eval_vars args, file
      content = eval_imports content
      content
    end

    def read_file(file)
      raise Kojo::NotFoundError, "File not found: #{file}" unless File.exist? file
      File.read file
    end

    def eval_imports(content)
      result = []

      content.compress_imports.lines.each do |line|
        line.chomp!
        spaces = line[/^\s*/].size

        if line =~ /^\s*@import ([^(\s]*)\s*(?:\((.*)\))?\s*/
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

    def import(file, import_args={})
      filename = File.expand_path "#{file}#{extension}", import_base
      all_args = args.merge import_args
      self.class.new(filename).render(all_args)
    end

    def indent(text, spaces)
      text.lines.collect { |line| "#{' ' * spaces}#{line}" }.join.gsub(/^\s*$/, '')
    end

  end
end
