require 'kojo/refinements/string'

module Kojo
  module Refinements
    refine Hash do
      def symbolize_keys
        transform_keys(&:to_sym)
      end

      def typecast_values
        transform_values(&:to_typed)
      end
    end
  end
end
