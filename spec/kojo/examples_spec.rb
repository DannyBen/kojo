require 'spec_helper'

describe 'examples' do
  it "work" do
    Dir['examples/*'].each do |example|
      name = File.basename example
      result = nil
      Dir.chdir example do
        result = `./runme 2>/dev/null`
      end
      puts "  --> #{name}"
      expect(result).to match_fixture("examples/#{name}")
    end
  end  
end
