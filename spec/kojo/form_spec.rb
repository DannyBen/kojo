require 'spec_helper'

describe Kojo::Form do
  subject { described_class.new 'spec/samples/form/movie.md' }

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

  describe '#warn' do
    let(:warning) { "Beware the door with too many keys" }

    it "delegates to TTY::Prompt" do
      expect(subject.prompt).to receive(:warn).with warning
      subject.warn warning
    end
  end

  describe '#method_missing' do
    it "forwards calls to a TTY::Prompt instance" do
      expect(subject.prompt).to receive(:hello)
      subject.hello
    end

    context "with positional args and keyword args" do
      it "works" do
        result = nil

        supress_output do
          send_input "" do
            expect { subject.select("Choose your destiny?", %w(Scorpion Kano Jax), cycle: true) }
              .to output(/Choose your destiny/).to_stdout
          end
        end
      end
    end

    context "when the method does not exist in TTY::Prompt" do
      it "raises an error" do
        expect { subject.hello }.to raise_error(NoMethodError)
      end
    end
  end
end
