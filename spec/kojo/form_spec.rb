require 'spec_helper'

describe Kojo::Form do
  subject { described_class.new 'examples/form/movie.md' }

  describe '#render' do
    it "prompts the user for values" do
      expected = /Your Name.*Bob.*Genre.*Action.*snacks.*Yes.*Snack.*Popcorn/m

      send_input "Bob", "", "y", "", "n" do
        expect { subject.render }.to output(expected).to_stdout
      end
    end

    it "renders the template properly" do
      result = nil
      
      supress_output do
        send_input "Bob", "", "y", "", "n" do
          result = subject.render
        end
      end

      expect(result).to match_fixture 'form'
    end
  end

  describe '#method_missing' do
    it "forwards calls to a TTY::Prompt instance" do
      expect(subject.prompt).to receive(:hello)
      subject.hello
    end

    it "raises an error when TTY::Prompt does not respond to this method" do
      expect { subject.hello }.to raise_error(NoMethodError)
    end
  end
end
