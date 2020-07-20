require 'spec_helper'

describe Kojo::Commands::FileCmd do
  subject { described_class }

  context "without arguments" do
    it "shows short usage" do
      expect { subject.execute %w[file]}.to output_approval('cli/file/usage')
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect { subject.execute %w[file --help] }.to output_approval('cli/file/help')
    end
  end
end
