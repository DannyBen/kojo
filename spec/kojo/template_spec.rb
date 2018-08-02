require 'spec_helper'

describe Template do
  let(:file) { 'somedir/somefile.yml' }
  let(:args) { { arg: 'value'} }
  subject { described_class.new file, args }

  describe '#initialize' do
    it "sets initial attributes" do
      expect(subject.file).to eq file
      expect(subject.args).to eq args
      expect(subject.extension).to eq '.yml'
      expect(subject.dir).to eq 'somedir'
    end
  end
end
