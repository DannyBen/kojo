require 'spec_helper'

describe 'examples' do
  subject { Kojo::CLI.runner }

  it 'work' do
    dirs = Dir['examples/*'].select { |f| File.directory?(f) and File.exist?("#{f}/runme") }
    # dirs = Dir["examples/dir"]

    dirs.each do |example|
      name = File.basename example
      puts "  --> #{name}"

      Dir.chdir example do
        cmd = `tail -n1 runme`
        args = cmd.split
        args.shift
        expect { subject.run args }.to output_approval("examples/stdout/#{name}")
      end

      result_file = "#{example}/result.yml"
      result_dir  = "#{example}/result"

      if File.exist? result_file
        puts '    > Verifying result file'
        expect(File.read result_file).to match_approval("examples/results/#{name}")
      end

      next unless Dir.exist? result_dir

      puts '    > Verifying result dir'
      files = Dir["#{result_dir}/**/*"].reject { |f| File.directory? f }
      files.each do |file|
        puts "    > Verifying #{file}"
        expect(File.read file).to match_approval("examples/results/#{file}")
      end
    end
  end
end
