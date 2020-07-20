require 'spec_helper'

describe Kojo::Commands::DirCmd do
  subject { described_class }

  context "without arguments" do
    it "shows short usage" do
      expect { subject.execute %w[dir]}.to output_approval('cli/dir/usage')
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect { subject.execute %w[dir --help] }.to output_approval('cli/dir/help')
    end
  end
end
