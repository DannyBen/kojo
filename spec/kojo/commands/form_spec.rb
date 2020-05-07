require 'spec_helper'

describe 'kojo form' do
  subject { Kojo::CLI.runner }

  context "without arguments" do
    it "shows short usage" do
      expect{ subject.run %w[form]}.to output_fixture('cli/form/usage')
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[form --help] }.to output_fixture('cli/form/help')
    end
  end

  context "with INFILE" do
    it "prompts the user for input and prints the template" do
      output = supress_output do
        send_input "Bob", "", "y", "", "n" do
          subject.run %w[form spec/samples/form/movie.md]
        end
      end

      expect(output).to match_fixture 'form-with-menu'
    end
  end

  context "with INFILE --save FILE" do
    before do
      system "rm tmp/form.md" if File.exist? 'tmp/form.md'
    end

    it "prompts the user for input and saves the template" do
      supress_output do
        send_input "Bob", "", "y", "", "n" do
          subject.run %w[form spec/samples/form/movie.md --save tmp/form.md]
        end
      end

      expect(File.read 'tmp/form.md').to match_fixture 'form'
    end
  end
end
