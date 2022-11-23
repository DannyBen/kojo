require 'spec_helper'

describe File do
  describe '::deep_write' do
    before do
      system 'rm -rf tmp/deep'
      expect(Dir).not_to exist('tmp/deep')
    end

    let(:file) { 'tmp/deep/dish/file.txt' }

    it 'creates the directory structure and writes the file' do
      described_class.deep_write file, 'works'
      expect(described_class).to exist(file)
      expect(described_class.read file).to eq 'works'
    end
  end
end
