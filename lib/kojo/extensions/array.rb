class Array
  def args_to_hash
    collect { |a| k, v = a.split '=' }.to_h.transform_keys(&:to_sym)
  end
end