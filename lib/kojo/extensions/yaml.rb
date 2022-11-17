require 'yaml'

module YAML
  # Make YAML.load behave the same in all Ruby versions
  # ref: https://bugs.ruby-lang.org/issues/17866
  class << self
    alias load unsafe_load if YAML.respond_to? :unsafe_load
  end
end
