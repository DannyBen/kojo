require 'kojo/extensions/string'

class Hash
  def symbolize_keys
    transform_keys &:to_sym
  end

  def typecast_values
    transform_values &:to_typed
  end
end