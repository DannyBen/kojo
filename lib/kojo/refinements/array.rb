require 'kojo/refinements/hash'

module Kojo
  module Refinements
    refine Array do
      # Convert an array of +["key=value", "key=value"]+ pairs to a hash
      def args_to_hash
        collect { |a| a.split '=' }
          .to_h
          .symbolize_keys
          .typecast_values
      end
    end
  end
end