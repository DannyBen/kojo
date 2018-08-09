require 'spec_helper'

describe 'bin/kojo' do
  subject { CLI.runner }

  it "shows list of commands" do
    expect{ subject.run }.to output_fixture('cli/commands')
  end
end
