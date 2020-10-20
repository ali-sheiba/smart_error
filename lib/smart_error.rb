# frozen_string_literal: true

require 'i18n'
require 'active_support'
require 'active_support/core_ext'
require 'smart_error/version'

I18n.config.available_locales = :en

module SmartError
  mattr_accessor :base_url
  @@base_url = nil

  mattr_accessor :excption_error_code
  @@excption_error_code = 1000

  mattr_accessor :model_error_code
  @@model_error_code = 1010

  # It accept [:first, :last, :sentence]
  mattr_accessor :model_error_message
  @@model_error_message = :first

  def self.handle(error, options = nil)
    case error
    when Integer
      SmartError::CustomError.new(error, options)
    when Exception
      SmartError::ExceptionError.new(error, options)
    when ApplicationRecord, ActiveRecord
      SmartError::ModelError.new(error, options)
    else
      SmartError::CustomError.new(1000, options)
    end
  end

  def self.config
    yield self
  end
end

require 'smart_error/base_error'
require 'smart_error/model_error'
require 'smart_error/custom_error'
require 'smart_error/exception_error'
