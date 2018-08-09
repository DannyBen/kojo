require 'spec_helper'

describe Template do
  let(:file) { 'somedir/somefile.yml' }
  let(:args) { { arg: 'value'} }
  subject { described_class.new file }

  describe '#initialize' do
    it "sets initial attributes" do
      expect(subject.file).to eq file
      expect(subject.extension).to eq '.yml'
      expect(subject.dir).to eq 'somedir'
    end
  end
end
