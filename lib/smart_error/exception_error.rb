# frozen_string_literal: true

module SmartError
  class ExceptionError < SmartError::BaseError
    def error_code
      SmartError.excption_error_code
    end

    def message
      @error.message
    end
  end
end
