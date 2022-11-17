require 'spec_helper'

describe 'bin/kojo' do
  subject { Kojo::CLI.runner }
  let(:command) { 'bin/kojo file spec/samples/basic.yml' }

  it 'shows list of commands' do
    expect { subject.run }.to output_approval('cli/commands')
  end

  context 'when KOJO_INTERACTIVE is unset' do
    before { ENV['KOJO_INTERACTIVE'] = nil }

    it 'prompts for user input on missing keys' do
      expect(`echo "domain.com\n2\n" | #{command}`).to match_approval('cli/file/user-input')
    end
  end

  context "when KOJO_INTERACTIVE is 'no'" do
    before { ENV['KOJO_INTERACTIVE'] = 'no' }
    after  { ENV['KOJO_INTERACTIVE'] = nil }

    it 'raises a friendly error on missing keys' do
      expect(`#{command} 2>&1`).to match_approval('cli/file/mising-key-error')
    end
  end
end
