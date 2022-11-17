module Kojo
  class Interrupt < Interrupt; end
  class Error < StandardError; end
  class TemplateError < Error; end
  class NotFoundError < Error; end
end
