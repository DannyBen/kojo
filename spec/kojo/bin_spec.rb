require 'spec_helper'

describe 'bin/kojo' do
  subject { CLI.runner }

  it "shows list of commands" do
    expect{ subject.run }.to output_fixture('cli/commands')
  end

  context "on exception" do
    it "errors gracefuly" do
      expect(`bin/kojo file no-such-file 2>&1`).to match_fixture('cli/exception')
    end
  end
end
