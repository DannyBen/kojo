require 'spec_helper'

describe 'bin/kojo-run' do
  subject { MisterBin::Runner.new 'kojo', basedir: 'bin' }

  context "without arguments" do
    it "shows short usage" do
      expect{ subject.run %w[run]}.to output_fixture('cli/run/usage')
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect{ subject.run %w[run --help] }.to output_fixture('cli/run/help')
    end
  end
end
