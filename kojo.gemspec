lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'
require 'kojo/version'

Gem::Specification.new do |s|
  s.name        = 'kojo'
  s.version     = Kojo::VERSION
  s.date        = Date.today.to_s
  s.summary     = "Configuration wizard"
  s.description = "Configuration wizard"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = Dir['bin/kojo*'].map { |f| File.basename f }
  s.homepage    = 'https://github.com/dannyben/kojo'
  s.license     = 'MIT'
  s.required_ruby_version = ">= 2.4.0"

  s.add_runtime_dependency 'mister_bin', '~> 0.2'

  s.add_development_dependency 'byebug', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'rspec_fixtures', '~> 0.3'
  s.add_development_dependency 'runfile', '~> 0.10'
  s.add_development_dependency 'runfile-tasks', '~> 0.4'
  s.add_development_dependency 'simplecov', '~> 0.15'
end
