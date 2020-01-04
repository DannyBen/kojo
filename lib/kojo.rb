require 'requires'
require 'byebug' if ENV['BYEBUG']

requires 'kojo/refinements'
requires 'kojo/extensions'

require 'kojo/exceptions'
require 'kojo/template'
require 'kojo/collection'
require 'kojo/config'
require 'kojo/front_matter_template'

module Kojo
  class << self
    def interactive?
      return @interactive unless @interactive.nil?
      @interactive = ENV['KOJO_INTERACTIVE'] == 'yes'
    end

    def interactive=(value)
      @interactive = value
    end
  end

end