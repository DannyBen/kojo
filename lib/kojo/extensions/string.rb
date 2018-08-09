class String
  # Convert a string to the most appropriate type
  def to_typed
    if self =~ /\A[+-]?\d+\Z/
      self.to_i

    elsif self =~ /\A[+-]?\d+\.\d+\Z/
      self.to_f

    elsif %w[yes no true false].include? downcase
      %w[yes true].include? downcase

    else
      self

    end
  end
end