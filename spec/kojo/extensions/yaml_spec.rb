require 'spec_helper'

describe YAML do
  describe '::load_file' do
    let(:file) { 'spec/samples/anchors.yml' }
    subject { YAML.load_file(file) }

    it 'loads files with anchors' do
      expect(subject['other']).to eq %w[one two]
    end
  end
end
