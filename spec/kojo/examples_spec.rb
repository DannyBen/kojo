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
    end
  end  
end
