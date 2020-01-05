require 'spec_helper'

describe Hash do
  using Kojo::Refinements

  describe '#symbolize_keys' do
    subject { {"key" => "val", "anotherkey" => "anotherval"} }

    it "converts keys to symbols" do
      expect(subject.symbolize_keys).to eq({ key: 'val', anotherkey: 'anotherval' })
    end
  end

  describe '#typecast_values' do
    subject { { str: "val", int: "1", float: "1.2", positive: "yes", negative: "no" } }

    it "converts values to most appropriate type" do
      expected = { str: "val", int: 1, float: 1.2, positive: true, negative: false }
      expect(subject.typecast_values).to eq(expected)
    end
  end
end
