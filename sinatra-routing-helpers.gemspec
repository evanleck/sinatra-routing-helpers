$:.unshift File.expand_path("../lib", __FILE__)
require 'sinatra/routing-helpers/version'

Gem::Specification.new do |spec|
  spec.name          = 'sinatra-routing-helpers'
  spec.version       = Sinatra::RoutingHelpers::VERSION
  spec.authors       = ['Evan Lecklider']
  spec.email         = ['evan.lecklider@gmail.com']
  spec.description   = 'Some simple helpers for routing and redirection.'
  spec.summary       = spec.description
  spec.homepage      = 'https://github.com/l3ck/sinatra-routing-helpers'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rack'
  spec.add_dependency 'sinatra', '~> 1.4.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
