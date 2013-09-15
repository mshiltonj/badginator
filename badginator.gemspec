# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'badginator/version'

Gem::Specification.new do |spec|
  spec.name          = "badginator"
  spec.version       = Badginator::VERSION
  spec.authors       = ["Steven Hilton"]
  spec.email         = ["mshiltonj@gmail.com"]
  spec.description   = %q{Add "badges" to any Rails model.}
  spec.summary       = %q{Badginator is a gem to add "badges" (or "trophies" or "achievements") to any model of a Rails application, like User or Player. Useful for game-oriented applications.}
  spec.homepage      = "https://github.com/mshiltonj/badginator"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 4.0.0"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "observr"


end
