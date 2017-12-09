# frozen_string_literal: true

module SmartError
  class ExceptionError < SmartError::BaseError
    def error_code
      # TODO: Configure Excption Error Code
      1000
    end

    def message
      @error.message
    end
  end
end
