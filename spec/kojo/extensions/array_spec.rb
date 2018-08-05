require 'spec_helper'

describe Hash do
  subject { {"key" => "val", "anotherkey" => "anotherval"} }

  describe '#symbolize_keys' do
    it "converts keys to symbols" do
      expect(subject.symbolize_keys).to eq({ key: 'val', anotherkey: 'anotherval' })
    end
  end
end
