require 'spec_helper'

describe YAML do
  describe '::load_file' do
    subject { described_class.load_file(file) }

    let(:file) { 'spec/samples/anchors.yml' }

    it 'loads files with anchors' do
      expect(subject['other']).to eq %w[one two]
    end
  end
end
