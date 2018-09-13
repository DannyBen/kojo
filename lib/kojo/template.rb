require 'erb'
require 'ostruct'

module Kojo
  # The Template class handles a single template file, and processes it for:
  # - Variables (using +%{var}+ syntax)
  # - ERB
  # - +@import+ statements
  class Template
    attr_reader :file, :extension, :dir, :args
    attr_accessor :import_base

    def initialize(file)
      @file = file
      @extension = File.extname file
      @dir = File.dirname file
      @import_base = dir
    end

    def render(args={})
      @args = args
      evaluate file
    end

    private

    def evaluate(file)
      content = read_file file
      content = eval_erb content
      content = eval_vars content
      content = eval_imports content
      content
    end

    def read_file(file)
      raise Kojo::NotFoundError, "File not found: #{file}" unless File.exist? file
      File.read file
    end

    def eval_vars(content)
      content.resolve args
    rescue ArgumentError => e
      raise Kojo::TemplateError, "#{e.message}\nin: #{file}"
    end

    def eval_erb(content)
      erb content, args
    rescue RuntimeError => e
      raise Kojo::TemplateError, "Invalid Ruby code #{e.message}\nin: #{file}"
    rescue SyntaxError => e
      raise Kojo::TemplateError, "#{e.message}\nin: #{file}"
    end

    def eval_imports(content)
      result = []
      
      content.lines.each do |line|
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

    def erb(template, vars)
      ERB.new(template, nil, '-').result(OpenStruct.new(vars).instance_eval { binding })
    end

    def indent(text, spaces)
      text.lines.collect { |line| "#{' ' * spaces}#{line}" }.join
    end
  end

end