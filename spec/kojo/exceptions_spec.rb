require 'spec_helper'

describe 'custom exceptions' do
  let(:runner) { Kojo::CLI.runner }
  let(:samples) { 'spec/samples/errors' }
  let(:empty_dir) { 'tmp/empty-dir' }

  let :cases do
    {
      unmatched_parens: %W[file #{samples}/unmatched-parens.yml],
      file_not_found:   %w[file no-file-here],
      dir_not_found:    %w[dir no-dir-here],
      empty_dir:        %W[dir #{empty_dir}],
      erb_syntax_error: %W[file #{samples}/erb-syntax-error.yml],
      erb_ruby_error:   %W[file #{samples}/erb-ruby-error.yml],
    }
  end

  it 'raises kojo errors' do
    FileUtils.mkdir_p empty_dir

    cases.each do |name, command|
      puts "  --> #{name}"
      expected = "exceptions/#{name}"
      actual = nil

      begin
        runner.run command
      rescue => e
        actual = "#{e.class}\n#{e.message}"
      end

      # Bigger difference in this case between RUby 2.6 and 2.5
      # TODO: Improve this you lazy bum...
      distance = name == :erb_syntax_error ? 30 : 2

      expect(actual).to match_approval(expected).diff(distance)
    end
  end
end
