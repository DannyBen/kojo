require 'spec_helper'

describe Kojo::Commands::ConfigCmd do
  subject { described_class }

  context "without arguments" do
    it "shows short usage" do
      expect { subject.execute %w[config]}.to output_approval('cli/config/usage')
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect { subject.execute %w[config --help] }.to output_approval('cli/config/help')
    end
  end
end
