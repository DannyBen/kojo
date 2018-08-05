require 'spec_helper'

describe 'bin/kojo-dir' do
  subject { CLI.runner }

  context "without arguments" do
    it "shows short usage" do
      expect{ subject.run %w[dir]}.to output_fixture('cli/dir/usage')
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[dir --help] }.to output_fixture('cli/dir/help')
    end
  end
end
