lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kojo/version'

Gem::Specification.new do |s|
  s.name        = 'kojo'
  s.version     = Kojo::VERSION
  s.summary     = 'Configuration Ninja'
  s.description = 'Generate configuration files from templates, using variables and definition files.'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = Dir['bin/kojo*'].map { |f| File.basename f }
  s.homepage    = 'https://github.com/dannyben/kojo'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.7.0'

  s.add_runtime_dependency 'colsole', '>= 0.8.1', '< 2'
  s.add_runtime_dependency 'erbx', '~> 0.1'
  s.add_runtime_dependency 'mister_bin', '~> 0.7'
  s.add_runtime_dependency 'requires', '~> 1.0'
  s.add_runtime_dependency 'tty-prompt', '~> 0.21'

  s.metadata['rubygems_mfa_required'] = 'true'
end
