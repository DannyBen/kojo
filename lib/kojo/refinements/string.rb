require 'erb'
require 'ostruct'

module Kojo
  module Refinements
    refine String do
      # Convert a string to the most appropriate type
      def to_typed
        if self =~ /\A[+-]?\d+\Z/
          self.to_i

        elsif self =~ /\A[+-]?\d+\.\d+\Z/
          self.to_f

        elsif %w[yes no true false].include? downcase
          %w[yes true].include? downcase

        else
          self

        end
      end

      def resolve(vars)
        self % vars.symbolize_keys
      
      rescue KeyError => e
        raise unless Kojo.interactive?

        print "> #{e.key}: "
        vars[e.key] = get_user_input
        retry
      end

      def eval_vars(args, filename)
        resolve args.symbolize_keys
      rescue ArgumentError => e
        raise Kojo::TemplateError, "#{e.message}\nin: #{filename}"
      end

      def eval_erb(args, filename)
        erb self, args
      rescue RuntimeError => e
        raise Kojo::TemplateError, "Invalid Ruby code #{e.message}\nin: #{filename}"
      rescue SyntaxError => e
        raise Kojo::TemplateError, "#{e.message}\nin: #{filename}"
      end

      def compress_imports
        gsub /^ *@import [^(\s]*\s*\([^)]+\)$/ do |match|
          match.gsub /\r?\n\s*/, " "
        end
      end

    private 

      def get_user_input
        response = $stdin.gets
        raise Kojo::Interrupt unless response # Ctrl+D
        response.chomp
      rescue ::Interrupt # Ctrl+C
        raise Kojo::Interrupt
      end

      def erb(template, vars)
        ERB.new(template, trim_mode: '-').result(OpenStruct.new(vars).instance_eval { binding })
      end

    end
  end
end