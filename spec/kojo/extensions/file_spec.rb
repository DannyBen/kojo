require 'spec_helper'

describe File do
  describe '::deep_write' do
    before do
      system 'rm -rf tmp/deep'
      expect(Dir).not_to exist('tmp/deep')
    end

    let(:file) { "tmp/deep/dish/file.txt" }

    it "creates the directory structure and writes the file" do
      File.deep_write file, "works"
      expect(File).to exist(file)
      expect(File.read file).to eq "works"
    end
  end
end
