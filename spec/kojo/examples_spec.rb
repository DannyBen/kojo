require 'spec_helper'

describe 'examples' do
  it "work" do
    dirs = Dir['examples/*'].select { |f| File.directory? f }
    dirs.each do |example|
      name = File.basename example
      result = nil
      Dir.chdir example do
        result = `bundle exec ./runme 2>/dev/null`
      end
      puts "  --> #{name}"
      expect(result).to match_fixture("examples/#{name}")

      result_file = "#{example}/result.yml"
      result_dir  = "#{example}/result"

      if File.exist? result_file
        puts "    > Verifying result file"
        expect(File.read result_file).to match_fixture("examples/results/#{name}")
      end

      if Dir.exist? result_dir
        puts "    > Verifying result dir"
        Dir["#{result_dir}/*"].each do |file|
          filename = File.basename file
          puts "    > Verifying #{filename}"
          expect(File.read file).to match_fixture("examples/results/#{filename}")
        end
      end
    end
  end  
end
