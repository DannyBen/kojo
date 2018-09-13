require 'spec_helper'

describe String do
  describe '#to_typed' do
    it "works with integer" do
      expect("123".to_typed).to eq 123
    end

    it "works with float" do
      expect("1.2".to_typed).to eq 1.2
    end

    it "is not confused by non-floats" do
      expect("1.2.3".to_typed).to eq "1.2.3"
    end

    it "works with truthy" do
      expect("yes".to_typed).to be true
      expect("true".to_typed).to be true
    end

    it "works with falsy" do
      expect("no".to_typed).to be false
      expect("false".to_typed).to be false
    end

    it "works with a string" do
      expect("boom".to_typed).to eq "boom"
    end

  end

  describe '#resolve' do
    subject { "hello %{name}" }

    it "substitutes variables in a string" do
      expect(subject.resolve name: 'world').to eq "hello world"
    end

    context "when the hash does not contain the needed variable" do
      it "prompts the user for input" do 
        send_input "bob" do
          expect{ subject.resolve({}) }.to output('> name: ').to_stdout
        end
      end

      it "uses the users input as the value" do
        supress_output do
          send_input "bob" do
            expect(subject.resolve({})).to eq "hello bob"
          end
        end
      end
    end
  end
end
