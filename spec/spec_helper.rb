require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

require 'mister_bin'
require 'kojo/cli'

require_relative 'tty_spec_helper'

system 'mkdir tmp' unless Dir.exist? 'tmp'

# Consistent Colsole output (for rspec_fixtures)
ENV['TTY'] = 'on'
ENV['COLUMNS'] = '80'
ENV['LINES'] = '30'

RSpec.configure do |rspec|
  rspec.include TTYSpecHelper, tty: true
  rspec.strip_ansi_escape = true
end
