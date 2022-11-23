require 'spec_helper'

describe Kojo do
  subject { described_class }

  describe '#interactive?' do
    before { described_class.interactive = nil }

    context 'when in library context' do
      it 'defaults to false' do
        expect(subject).not_to be_interactive
      end

      context 'when KOJO_INTERACTIVE == yes' do
        before { ENV['KOJO_INTERACTIVE'] = 'yes' }
        after  { ENV['KOJO_INTERACTIVE'] = nil }

        it 'returns true' do
          expect(subject).to be_interactive
        end
      end
    end

    context 'when in CLI context' do
      it 'defaults to true' do
        expect(subject).not_to be_interactive
        Kojo::CLI.runner
        expect(subject).to be_interactive
      end

      context 'when KOJO_INTERACTIVE == no' do
        before { ENV['KOJO_INTERACTIVE'] = 'no' }
        after  { ENV['KOJO_INTERACTIVE'] = nil }

        it 'returns false' do
          expect(subject).not_to be_interactive
          Kojo::CLI.runner
          expect(subject).not_to be_interactive
        end
      end
    end
  end
end
