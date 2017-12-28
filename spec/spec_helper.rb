# frozen_string_literal: true

require 'bundler/setup'
require 'smart_error'

class ActiveRecord
  def errors
    OpenStruct.new(
      full_messages: ["Username can't be blank", "First name can't be blank", "Last name can't be blank", "Email can't be blank", 'Email is invalid'],
      details:  { username: [{ error: :blank }], first_name: [{ error: :blank }], last_name: [{ error: :blank }], email: [{ error: :blank }, { error: :invalid }] },
      messages: { username: ["can't be blank"], first_name: ["can't be blank"], last_name: ["can't be blank"], email: ["can't be blank", 'is invalid'] }
    )
  end
end

class ApplicationRecord < ActiveRecord; end
class ExampleModel < ApplicationRecord; end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

I18n.load_path << $LOAD_PATH[0] + '/../spec/en.yml'
