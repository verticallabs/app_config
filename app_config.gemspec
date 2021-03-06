# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'app_config/version'

Gem::Specification.new do |gem|
  gem.name          = "app_config"
  gem.version       = AppConfig::VERSION
  gem.authors       = ["Paul Schuegraf"]
  gem.email         = ["paul@verticallabs.ca"]
  gem.description   = %q{Simple Rails configuration file loader.}
  gem.summary       = %q{Simple Rails configuration file loader.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'recursive-open-struct'
  gem.add_dependency 'rails'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'combustion'
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'debugger'
end
