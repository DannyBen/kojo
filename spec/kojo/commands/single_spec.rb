require 'spec_helper'

describe 'kojo single' do
  subject { Kojo::CLI.runner }

  context "without arguments" do
    it "shows short usage" do
      expect{ subject.run %w[single]}.to output_fixture('cli/single/usage')
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[single --help] }.to output_fixture('cli/single/help')
    end
  end
end
