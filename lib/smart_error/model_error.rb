# frozen_string_literal: true

module SmartError
  class ModelError < SmartError::BaseError
    def error_code
      SmartError.model_error_code
    end

    def message
      @error.
        errors.
        full_messages.
        send(
          action[SmartError.model_error_message] || :first
        )
    end

    def details
      @error.errors.messages.transform_values(&:to_sentence)
    end

    def action
      {
        first: :first,
        last: :last,
        sentence: :to_sentence
      }
    end
  end
end
