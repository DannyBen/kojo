require 'spec_helper'

describe Kojo::Commands::ToJsonCmd do
  subject { described_class }

  context 'without arguments' do
    it 'shows short usage' do
      expect { subject.execute %w[tojson] }.to output_approval('cli/tojson/usage')
    end
  end

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.execute %w[tojson --help] }.to output_approval('cli/tojson/help')
    end
  end

  context 'with arguments' do
    before { system 'rm -rf tmp/clean-yamls ; cp -R spec/samples/clean-yamls tmp/' }

    let(:args) { ['tojson', input] }

    context 'with a single INPUT file' do
      let(:input) { 'tmp/clean-yamls/sample1.yml' }
      let(:output) { 'tmp/clean-yamls/sample1.json' }

      it 'outputs the JSON encoded version of the file' do
        expect { subject.execute args }.to output_approval('cli/tojson/single-file')
      end

      context 'with --save' do
        let(:args) { ['tojson', input, '--save'] }

        it 'saves to the same directory' do
          expect(File).not_to exist(output)

          expect { subject.execute args }.to output_approval('cli/tojson/single-file-save')

          expect(File).to exist(output)
          expect(File.read output).to match_approval('cli/tojson/single-file-save-content')
        end
      end

      context 'with --replace' do
        let(:args) { ['tojson', input, '--replace'] }

        it 'saves to the same directory and deletes the original' do
          expect(File).not_to exist(output)

          expect { subject.execute args }.to output_approval('cli/tojson/single-file-save')

          expect(File).to exist(output)
          expect(File).not_to exist(input)
          expect(File.read output).to match_approval('cli/tojson/single-file-save-content')
        end
      end
    end

    context 'with a multiple INPUT files' do
      let(:input) { 'tmp/clean-yamls/*.yml' }
      let(:output) { 'tmp/clean-yamls/*.json' }

      it 'outputs the JSON encoded version of all the files' do
        expect { subject.execute args }.to output_approval('cli/tojson/multiple-file')
      end

      context 'with --save' do
        let(:args) { ['tojson', input, '--save'] }

        it 'saves to the same directory' do
          expect(Dir[output]).to be_empty

          expect { subject.execute args }.to output_approval('cli/tojson/multiple-file-save')

          expect(Dir[output]).to eq ['tmp/clean-yamls/sample1.json', 'tmp/clean-yamls/sample2.json']
          expect(Dir[input]).not_to be_empty
          expect(File.read Dir[output].min).to match_approval('cli/tojson/single-file-save-content')
        end
      end

      context 'with --replace' do
        let(:args) { ['tojson', input, '--replace'] }

        it 'saves to the same directory and deletes the original' do
          expect(Dir[output]).to be_empty

          expect { subject.execute args }.to output_approval('cli/tojson/multiple-file-save')

          expect(Dir[output]).to eq ['tmp/clean-yamls/sample1.json', 'tmp/clean-yamls/sample2.json']
          expect(Dir[input]).to be_empty
          expect(File.read Dir[output].min).to match_approval('cli/tojson/single-file-save-content')
        end
      end
    end
  end
end
