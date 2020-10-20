# SmartError

[![Ruby Gem](https://img.shields.io/gem/v/smart_error.svg)](https://rubygems.org/gems/smart_error)
[![Build Status](https://travis-ci.org/ali-sheiba/smart_error.svg?branch=master)](https://travis-ci.org/ali-sheiba/smart_error)

Simple gem that can handle Exceptions, ActiveRecord Errors and Custom Errors and return readable message and error number/code as usable Hash.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [SmartError](#smarterror)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Handle integer as CustomError](#handle-integer-as-customerror)
    - [Handle ApplicationRecord as ModelError](#handle-applicationrecord-as-modelerror)
    - [Handle ActiveRecord child as ModelError](#handle-activerecord-child-as-modelerror)
    - [handle Exception as ExceptionError](#handle-exception-as-exceptionerror)
    - [Override the message with the provided message](#override-the-message-with-the-provided-message)
    - [Merge `extra` array to message](#merge-extra-array-to-message)
    - [Merge `extra` string to message](#merge-extra-string-to-message)
    - [Merge `extra` with custom message](#merge-extra-with-custom-message)
    - [Show First Model Errors by default](#show-first-model-errors-by-default)
    - [Show Model Error details by invalid keys and messages and convert messages to sentence](#show-model-error-details-by-invalid-keys-and-messages-and-convert-messages-to-sentence)
  - [Contributing](#contributing)
  - [License](#license)
  - [Code of Conduct](#code-of-conduct)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'smart_error'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install smart_error
```

## Usage
First of all will need to have predefined list of error messages Like: [errors](https://github.com/ali-sheiba/smart_error/blob/master/spec/en.yml)


### Handle integer as CustomError

```ruby
SmartError.handle(1001).to_h
# {:message=>"Unauthorized", :details=>{}, :error_url=>"1001", :error_code=>1001}

SmartError.handle(1001).to_json
# "{\"message\":\"Unauthorized\",\"details\":{},\"error_url\":\"1001\",\"error_code\":1001}"

SmartError.handle(1001, options).as_json
# {"message"=>"Unauthorized", "details"=>{}, "error_url"=>"1001", "error_code"=>1001}
```

### Handle ApplicationRecord as ModelError
```ruby
SmartError.handle(Employee.new).to_h
# {:message=>"", :details=>{}, :error_url=>"1010", :error_code=>1010}
```

### Handle ActiveRecord child as ModelError
```ruby
SmartError.handle(ApplicationRecord.new).to_h
```

### handle Exception as ExceptionError
```ruby
SmartError.handle(NoMethodError.new).to_h
# {:message=>"NoMethodError", :details=>{}, :error_url=>"1000", :error_code=>1000}
```

### Override the message with the provided message
```ruby
message = 'Custom Message'
SmartError.handle(1001, message: message).to_h
# {:message=>"Custom Message", :details=>{}, :error_url=>"1001", :error_code=>1001}
```

### Merge `extra` array to message
```ruby
extra = %i[username password country]
error = SmartError.handle(1002, extra: extra)
error.to_h
# {:message=>"Not Found: username, password, and country", :details=>{}, :error_url=>"1002", :error_code=>1002}
```

### Merge `extra` string to message
```ruby
extra = 'you are noy authorized for this action'
error = SmartError.handle(1001, extra: extra)
error.to_h
# {:message=>"Unauthorized: you are noy authorized for this action", :details=>{}, :error_url=>"1001", :error_code=>1001}
```

### Merge `extra` with custom message
```ruby
extra = %i[username password country]
message = 'Missing Parameters'
error = SmartError.handle(1001, message: message, extra: extra)
error.to_h
# {:message=>"Missing Parameters: username, password, and country", :details=>{}, :error_url=>"1001", :error_code=>1001}
```

### Show First Model Errors by default
```ruby
SmartError.handle(ExampleModel.new).to_h
```
### Show Model Error details by invalid keys and messages and convert messages to sentence
```ruby
error = SmartError.handle(ExampleModel.new)
error.to_h[:details] # 'can\'t be blank'
error.to_h[:details] # 'can\'t be blank and is invalid'
```
## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/ali-sheiba/smart_error>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SmartError project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ali-sheiba/smart_error/blob/master/CODE_OF_CONDUCT.md).