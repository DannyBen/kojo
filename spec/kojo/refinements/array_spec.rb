require 'spec_helper'

describe Array do
  using Refinements

  subject { %w[scale=2 production=yes app=ninja] }

  describe '#args_to_hash' do
    it "converts array of 'key=value' to symbolized and typed hash" do
      expect(subject.args_to_hash).to eq({ scale: 2, production: true, app: "ninja" })
    end
  end
end
