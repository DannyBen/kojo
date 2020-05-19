require 'spec_helper'

describe 'kojo file' do
  subject { Kojo::CLI.runner }

  context "without arguments" do
    it "shows short usage" do
      expect{ subject.run %w[file]}.to output_approval('cli/file/usage')
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[file --help] }.to output_approval('cli/file/help')
    end
  end
end
