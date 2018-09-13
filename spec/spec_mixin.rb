require 'stringio'

module SpecMixin
  def send_input(*args)
    begin
      $stdin = StringIO.new
      $stdin.puts(args.shift) until args.empty?
      $stdin.rewind
      yield
    ensure
      $stdin = STDIN
    end
  end

  def supress_output
    original_stdout = $stdout
    $stdout = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
  end
end