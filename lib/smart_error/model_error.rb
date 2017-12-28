# frozen_string_literal: true

module SmartError
  class ModelError < SmartError::BaseError
    def error_code
      SmartError.model_error_code
    end

    def message
      action = case SmartError.model_error_message
               when :first then :first
               when :sentence then :to_sentence
               when :last then :last
               else :first
               end

      @error.errors.full_messages.send(action)
    end

    def details
      @error.errors.messages.transform_values(&:to_sentence)
    end
  end
end
