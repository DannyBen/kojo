require 'spec_helper'

describe Array do
  subject { ['key=val', 'anotherkey=anotherval'] }

  describe '#args_to_hash' do
    it "converts array of 'key=value' to hash" do
      expect(subject.args_to_hash).to eq({ key: 'val', anotherkey: 'anotherval' })
    end
  end
end
