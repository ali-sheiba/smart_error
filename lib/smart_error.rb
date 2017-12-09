require "smart_error/version"

module SmartError
  # Your code goes here...

  def config
    yield self
  end
end
