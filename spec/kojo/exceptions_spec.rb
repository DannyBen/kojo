require 'spec_helper'

describe 'custom exceptions' do
  let(:runner) { CLI.runner }
  let(:samples) { 'spec/samples/errors' }
  let(:empty_dir) { 'tmp/empty-dir' }
  
  let :cases do
    {
      unmatched_parens: %W[file #{samples}/unmatched-parens.yml],
      missing_arg:      %W[file #{samples}/missing-arg.yml],
      file_not_found:   %W[file no-file-here],
      dir_not_found:    %W[dir no-dir-here],
      empty_dir:        %W[dir #{empty_dir}],
      erb_syntax_error: %W[file #{samples}/erb-syntax-error.yml],
      erb_ruby_error:   %W[file #{samples}/erb-ruby-error.yml],
    }
  end

  it 'raise kojo errors' do
    FileUtils.mkdir_p empty_dir unless Dir.exist? empty_dir

    cases.each do |name, command|
      puts "  --> #{name}"
      expected, actual = "exceptions/#{name}", nil

      begin
        runner.run command
      rescue Exception => e
        actual = "#{e.class}\n#{e.message}"
      end
      
      expect(actual).to match_fixture(expected)
    end
  end
end
