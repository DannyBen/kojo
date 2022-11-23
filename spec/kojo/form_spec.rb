require 'spec_helper'

describe Kojo::Form, :tty do
  subject { described_class.new 'spec/samples/form/movie.md' }

  describe '#render' do
    it 'prompts for values and returns the evaluated template' do
      ask 'Bob'
      select 'Action'
      yes? true
      select 'Pizza'
      yes? false

      expect(subject.render).to match_approval 'form'
    end
  end

  describe '#warn' do
    let(:warning) { 'Beware the door with too many keys' }

    it 'delegates to TTY::Prompt' do
      expect(subject.prompt).to receive(:warn).with warning
      subject.warn warning
    end
  end

  describe '#method_missing' do
    it 'forwards calls to a TTY::Prompt instance' do
      expect(subject.prompt).to receive(:hello)
      subject.hello
    end

    context 'with positional args and keyword args' do
      let(:args) { ['Choose your destiny?', %w[Scorpion Kano Jax], { cycle: true }] }

      it 'forwards calls to a TTY::Prompt instance' do
        expect(subject.prompt).to receive(:select).with(*args).and_return('Jax')
        subject.select(*args)
      end
    end

    context 'when the method does not exist in TTY::Prompt' do
      it 'raises an error' do
        expect { subject.hello }.to raise_error(NoMethodError)
      end
    end
  end
end
