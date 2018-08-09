require 'spec_helper'

describe String do
  describe '#to_type' do
    it "works with integer" do
      expect("123".to_type).to eq 123
    end

    it "works with float" do
      expect("1.2".to_type).to eq 1.2
    end

    it "is not confused by non-floats" do
      expect("1.2.3".to_type).to eq "1.2.3"
    end

    it "is works with truthy" do
      expect("yes".to_type).to be true
      expect("true".to_type).to be true
    end

    it "is works with falsy" do
      expect("no".to_type).to be false
      expect("false".to_type).to be false
    end

    it "works with a string" do
      expect("boom".to_type).to eq "boom"
    end

  end
end
