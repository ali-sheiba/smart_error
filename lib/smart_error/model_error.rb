# frozen_string_literal: true

module SmartError
  class ModelError < SmartError::BaseError
    def error_code
      # TODO: Configure Model Error Code
      1010
    end

    def message
      # TODO: Configure first or all full messages
      @error.errors.full_messages.to_sentence
    end

    # TODO: Show Full Model Errors
    def details
      {}
    end
  end
end
