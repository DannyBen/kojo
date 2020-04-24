require 'erbx'
require 'tty-prompt'

module Kojo
  # The Form class handles interactive ERBX templates
  class Form
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def content
      @content ||= content!
    end

    def content!
      content = File.read file
      ruby_code = File.exist?("#{file}.rb") ? File.read("#{file}.rb") : nil
      content = "<%-\n#{ruby_code}\n-%>\n#{content}" if ruby_code
      content
    end

    def render
      ERBX.new(content).result(binding)
    rescue TTY::Reader::InputInterrupt
      # :nocov:
      raise Kojo::Interrupt
      # :nocov:
    end

    def prompt
      @prompt ||= TTY::Prompt.new
    end

    # We need this since it is not captured by `mthod_missing`.
    def select(*args, &block)
      prompt.select *args, &block
    end

    def method_missing(method_name, *args, &block)
      if respond_to? method_name
        prompt.send method_name, *args, *block
      else
        super
      end
    end

    def respond_to?(method_name, include_private = false)
      prompt.respond_to?(method_name) || super
    end

  end
end