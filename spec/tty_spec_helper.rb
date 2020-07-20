require 'stringio'

module TTYSpecHelper
  def stdin(input)
    expect($stdin).to receive(:gets).and_return input
  end

  def ask(input)
    answer :ask, with: input
  end

  def yes?(input)
    answer :yes?, with: input
  end

  def select(input)
    answer :select, with: input
  end

  def answer(method, with:)
    expect(subject.prompt).to receive(method.to_sym).and_return(with)
  end

  def supress_output
    original_stdout = $stdout
    output = StringIO.new
    $stdout = output
    begin
      yield
    ensure
      $stdout = original_stdout
    end
    output.string
  end
end
