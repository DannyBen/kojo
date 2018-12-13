lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'
require 'kojo/version'

Gem::Specification.new do |s|
  s.name        = 'kojo'
  s.version     = Kojo::VERSION
  s.date        = Date.today.to_s
  s.summary     = "Configuration Ninja"
  s.description = "Generate configuration files from templates, using variables and definition files."
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = Dir['bin/kojo*'].map { |f| File.basename f }
  s.homepage    = 'https://github.com/dannyben/kojo'
  s.license     = 'MIT'
  s.required_ruby_version = ">= 2.5.0"

  s.add_runtime_dependency 'mister_bin', '~> 0.6'
  s.add_runtime_dependency 'requires', '~> 0.1'
  s.add_runtime_dependency 'colsole', '~> 0.5'
end
