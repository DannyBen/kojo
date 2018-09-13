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

  def resolve(vars)
    self % vars
  
  rescue KeyError => e
    print "> #{e.key}: "
    response = $stdin.gets
    
    raise Kojo::TemplateError, e.message unless response

    vars[e.key] = response.chomp
    retry
  end

end