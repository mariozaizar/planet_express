# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'planet_express/version'

Gem::Specification.new do |gem|
  gem.name          = "planet_express"
  gem.version       = PlanetExpress::VERSION
  gem.authors       = ["Mario Zaizar"]
  gem.email         = ["mariozaizar@gmail.com"]
  gem.description   = %q{An intergalactic email delivery library to send Emails with Silverpop provider.}
  gem.summary       = %q{Planet Express, Inc. is an intergalactic email delivery library built in Ruby. Is meant to be used with Silverpop mailing system, to provide an easy way to send emails. We're using it with Rails 3 apps.}
  gem.homepage      = "https://github.com/mariozaizar/planet_express"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activesupport'
  gem.add_dependency 'hpricot'
  gem.add_dependency 'log4r'

  gem.add_development_dependency 'awesome_print'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-bundler'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec'
end
