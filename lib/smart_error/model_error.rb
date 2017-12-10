# frozen_string_literal: true

module SmartError
  class ModelError < SmartError::BaseError
    def error_code
      SmartError.model_error_code
    end

    def message
      case SmartError.model_error_message
      when :first then @error.errors.full_messages.first
      when :sentence then @error.errors.full_messages.to_sentence
      when :last then @error.errors.full_messages.last
      else @error.errors.full_messages.first
      end
    end

    def details
      @error.errors.details
    end
  end
end
