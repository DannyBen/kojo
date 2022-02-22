require 'spec_helper'

describe Kojo::Commands::FormCmd do
  subject { described_class }

  context "without arguments" do
    it "shows short usage" do
      expect { subject.execute %w[form]}.to output_approval('cli/form/usage')
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect { subject.execute %w[form --help] }.to output_approval('cli/form/help')
    end
  end

  context "with arguments" do
    let(:infile) { 'spec/samples/form/movie.md' }
    let(:template) { double :template, render: "rendered" }

    context "INFILE" do
      let(:args) { ['form', infile] }

      it "delegates the INFILE to Kojo::Form" do
        expect(Kojo::Form).to receive(:new).with(infile).and_return(template)
        expect(template).to receive(:render)
        subject.execute args
      end
    end

    context "INFILE --save FILE" do
      let(:outfile) { 'tmp/form.md' }
      let(:args) { %W[form #{infile} --save #{outfile}] }
      before { File.delete outfile if File.exist? outfile }

      it "prompts the user for input and saves the template" do
        expect(Kojo::Form).to receive(:new).with(infile).and_return(template)
        expect(template).to receive(:render).and_return('rendered')
        expect { subject.execute args }.to output("Saved #{outfile}\n").to_stdout
        expect(File.read outfile).to eq "rendered"
      end
    end
  end
end

