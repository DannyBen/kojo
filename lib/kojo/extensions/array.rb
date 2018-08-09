require 'kojo/extensions/hash'

class Array
  def args_to_hash
    collect { |a| k, v = a.split '=' }
      .to_h
      .symbolize_keys
      .typecast_values
  end
end