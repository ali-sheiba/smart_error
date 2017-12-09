# frozen_string_literal: true

module SmartError
  class CustomError < SmartError::BaseError
    def error_code
      @error.to_i
    end

    def message
      I18n.t("errors.#{error_code}")
    end
  end
end
