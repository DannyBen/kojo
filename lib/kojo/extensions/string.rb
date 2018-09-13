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
    vars[e.key] = get_user_input
    retry
  end

  private 

  def get_user_input
    response = $stdin.gets
    raise Kojo::Interrupt unless response # Ctrl+D
    response.chomp
  rescue Interrupt # Ctrl+C
    raise Kojo::Interrupt
  end
end