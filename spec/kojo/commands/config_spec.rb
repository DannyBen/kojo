require 'spec_helper'

describe 'kojo config' do
  subject { Kojo::CLI.runner }

  context "without arguments" do
    it "shows short usage" do
      expect{ subject.run %w[config]}.to output_approval('cli/config/usage')
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[config --help] }.to output_approval('cli/config/help')
    end
  end
end
