# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SmartError do
  it 'has a version number' do
    expect(SmartError::VERSION).not_to be nil
  end

  it 'handle integer as CustomError' do
    error = SmartError.handle(1001)
    expect(error.class).to be SmartError::CustomError
  end

  it 'handle ApplicationRecord as ModelError' do
    error = SmartError.handle(ExampleModel.new)
    expect(error.class).to be SmartError::ModelError
  end

  it 'handle ActiveRecord child as ModelError' do
    error = SmartError.handle(ApplicationRecord.new)
    expect(error.class).to be SmartError::ModelError
  end

  it 'handle Exception as ExceptionError' do
    error = SmartError.handle(NoMethodError.new)
    expect(error.class).to be SmartError::ExceptionError
  end

  it 'fetch show the message by the error number' do
    error = SmartError.handle(1001)
    expect(error.class).to be SmartError::CustomError
    expect(error.to_h).to include(message: I18n.t('errors.1001'))
    expect(error.to_h).to include(error_code: 1001)
  end

  it 'override the message with the provided message' do
    message = 'Custom Message'
    error = SmartError.handle(1001, message: message)
    expect(error.to_h).to include(message: message)
    expect(error.to_h).to include(error_code: 1001)
  end

  it 'merge `extra` array to message' do
    extra = %i[username password country]
    error = SmartError.handle(1001, extra: extra)
    expect(error.to_h).to include(message: I18n.t('errors.1001') + ': ' + extra.to_sentence)
    expect(error.to_h).to include(error_code: 1001)
  end

  it 'merge `extra` string to message' do
    extra = 'you are noy authorized for this action'
    error = SmartError.handle(1001, extra: extra)
    expect(error.to_h).to include(message: I18n.t('errors.1001') + ': ' + extra)
    expect(error.to_h).to include(error_code: 1001)
  end

  it 'merge `extra` with custom message' do
    extra = %i[username password country]
    message = 'Missing Parameters'
    error = SmartError.handle(1001, message: message, extra: extra)
    expect(error.to_h).to include(message: message + ': ' + extra.to_sentence)
    expect(error.to_h).to include(error_code: 1001)
  end

  # TODO : Configuration
end
