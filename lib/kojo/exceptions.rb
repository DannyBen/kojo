module Kojo
  class Error < StandardError; end
  class TemplateError < Error; end
  class NotFoundError < Error; end
end