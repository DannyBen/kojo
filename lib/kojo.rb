require 'requires'
require 'byebug' if ENV['BYEBUG']

require 'yaml'
require 'json'

requires 'kojo/extensions'
requires 'kojo/refinements'

require 'kojo/exceptions'
require 'kojo/template'
require 'kojo/collection'
require 'kojo/config'
require 'kojo/front_matter_template'
require 'kojo/form'

module Kojo
  class << self
    attr_writer :interactive

    def interactive?
      return @interactive unless @interactive.nil?

      @interactive = ENV['KOJO_INTERACTIVE'] == 'yes'
    end
  end
end
