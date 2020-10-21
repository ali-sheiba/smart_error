# frozen_string_literal: true

module SmartError
  # The Base Class of Errors
  class BaseError
    def initialize(error, options = {})
      @error   = error
      @options = options&.symbolize_keys! || {}
    end

    # :nocov:
    def not_implemented
      raise NotImplementedError
    end

    alias message not_implemented
    alias error_code not_implemented
    # :nocov:

    def details
      {}
    end

    def error_url
      SmartError.base_url.to_s + (error_code || 1000).to_s
    end

    def full_message
      [
        @options[:message].present? ? @options[:message] : message,
        extra_message
      ].compact.join(': ')
    end

    def extra_message
      if @options[:extra].is_a?(Array)
        @options[:extra].map(&:to_s).to_sentence
      elsif @options[:extra].is_a?(String)
        @options[:extra]
      end
    end

    def to_h
      {
        message:    full_message,
        details:    details,
        error_url:  error_url,
        error_code: error_code
      }
    end

    def to_json
      to_h.to_json
    end

    def as_json
      to_h.as_json
    end
  end
end
