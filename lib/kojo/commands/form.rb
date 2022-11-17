require 'mister_bin'

module Kojo
  module Commands
    # Handle calls to the +kojo form+ command
    class FormCmd < CommandBase
      attr_reader :infile, :outdir

      help 'Fill a template form interactively'

      usage 'kojo form INFILE [--save FILE]'
      usage 'kojo form (-h|--help)'

      option '-s --save FILE', 'Save to file instead of printing'

      param 'INFILE', 'ERBX template to transform'

      example 'kojo form report.md'
      example 'kojo form report.md --save output.md'

      def run
        infile = args['INFILE']
        outfile = args['--save']
        template = Kojo::Form.new infile

        if outfile
          save outfile, template.render
        else
          puts template.render
        end
      end
    end
  end
end
