require 'stringio'

module SpecMixin
  def capture_stdout
    begin
      old_stdout = $stdout
      $stdout = StringIO.new
      yield
      $stdout.string
    ensure
      $stdout = old_stdout
    end
  end
end