class String
  def to_typed
    if self =~ /\A[+-]?\d+\Z/
      self.to_i

    elsif self =~ /\A[+-]?\d+\.\d+\Z/
      self.to_f

    elsif %w[yes no true false].include? self.downcase
      %w[yes true].include? self.downcase

    else
      self

    end
  end
end