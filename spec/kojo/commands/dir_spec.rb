require 'spec_helper'

describe 'kojo dir' do
  subject { Kojo::CLI.runner }

  context "without arguments" do
    it "shows short usage" do
      expect{ subject.run %w[dir]}.to output_approval('cli/dir/usage')
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[dir --help] }.to output_approval('cli/dir/help')
    end
  end
end
