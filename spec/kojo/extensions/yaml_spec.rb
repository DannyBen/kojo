require 'spec_helper'

describe YAML do
  describe '::properly_load_file' do
    let(:file) { "spec/samples/anchors.yml" }
    subject { YAML.properly_load_file(file) }

    it "loads files with anchors" do
      expect(subject['other']).to eq ["one", "two"]
    end
  end
end
