# frozen_string_literal: true

require 'i18n'
require 'active_support'
require 'active_support/core_ext'
require 'smart_error/version'

I18n.config.available_locales = :en

module SmartError
  # mattr_accessor :default_error_code
  # @@default_error_code = 1000

  # mattr_accessor :model_error_code
  # @@model_error_code = 1010

  def self.handle(error, options = nil)
    if error.is_a?(Integer)
      SmartError::CustomError.new(error, options)
    elsif error.is_a?(Exception)
      SmartError::ExceptionError.new(error, options)
    elsif error.is_a?(ApplicationRecord) || error.is_a?(ActiveRecord)
      SmartError::ModelError.new(error, options)
    else
      SmartError::CustomeError.new(1000, options)
    end
  end

  # TODO: Configurations
  def config
    yield self
  end
end

require 'smart_error/base_error'
require 'smart_error/model_error'
require 'smart_error/custom_error'
require 'smart_error/exception_error'
