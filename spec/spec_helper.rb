require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

require 'mister_bin'
require 'kojo/cli'

require_relative 'spec_mixin'

system 'mkdir tmp' unless Dir.exist? 'tmp'

# Consistent Colsole output (for rspec_fixtures)
ENV['TTY'] = 'on'

RSpec.configure do |c|
  c.include SpecMixin
end
