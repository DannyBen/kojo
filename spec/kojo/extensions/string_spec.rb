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

    it "is works with truthy" do
      expect("yes".to_typed).to be true
      expect("true".to_typed).to be true
    end

    it "is works with falsy" do
      expect("no".to_typed).to be false
      expect("false".to_typed).to be false
    end

    it "works with a string" do
      expect("boom".to_typed).to eq "boom"
    end

  end
end
