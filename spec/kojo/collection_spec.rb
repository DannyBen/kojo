require 'spec_helper'

describe Kojo::Collection do
  subject { described_class.new 'examples/dir/templates' }

  describe '#size' do
    it 'returns the file count' do
      expect(subject.size).to eq 3
    end
  end
end
