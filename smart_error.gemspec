# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smart_error/version'

Gem::Specification.new do |spec|
  spec.name          = 'smart_error'
  spec.version       = SmartError::VERSION
  spec.authors       = ['Ali Al-Sheiba']
  spec.email         = ['ali.alsheiba@gmail.com']

  spec.summary       = 'Simple way to handle custom error codes and messages'
  spec.description   = 'Simple way to maintain custom error codes and there messages with I18n.'
  spec.homepage      = 'https://github.com/ali-sheiba/smart_error'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_dependency 'activesupport', '>= 5.0'
  spec.add_dependency 'i18n', '>= 0.8'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
end
