require 'spec_helper'

describe 'examples' do
  it "work" do
    dirs = Dir['examples/*'].select { |f| File.directory? f }

    # dirs = Dir["examples/06*"]

    dirs.each do |example|
      name = File.basename example
      result = nil
      Dir.chdir example do
        result = `bundle exec ./runme 2>/dev/null`
      end
      puts "  --> #{name}"
      expect(result).to match_fixture("examples/stdout/#{name}")

      result_file = "#{example}/result.yml"
      result_dir  = "#{example}/result"

      if File.exist? result_file
        puts "    > Verifying result file"
        expect(File.read result_file).to match_fixture("examples/results/#{name}")
      end

      if Dir.exist? result_dir
        puts "    > Verifying result dir"
        files = Dir["#{result_dir}/**/*"].reject { |f| File.directory? f }
        files.each do |file|
          puts "    > Verifying #{file}"
          expect(File.read file).to match_fixture("examples/results/#{file}")
        end
      end
    end
  end  
end
