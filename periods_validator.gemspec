# coding: utf-8

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'periods_validator/version'

Gem::Specification.new do |spec|
  spec.name          = 'periods_validator'
  spec.version       = PeriodsValidator::VERSION
  spec.authors       = ['Javier Ponferrada López']
  spec.email         = ['jponferrada26@gmail.com']
  spec.summary       = 'Validates periods between two date ranges'
  spec.description   = 'Validates periods between two date ranges'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'activesupport'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'activerecord', ['>= 3.0', '< 5.3']
end
