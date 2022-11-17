require 'spec_helper'

describe Kojo::Commands::SingleCmd do
  subject { described_class }

  context 'without arguments' do
    it 'shows short usage' do
      expect { subject.execute %w[single] }.to output_approval('cli/single/usage')
    end
  end

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.execute %w[single --help] }.to output_approval('cli/single/help')
    end
  end
end
