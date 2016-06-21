# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'berg/version'

Gem::Specification.new do |spec|
  spec.name          = "berg"
  spec.version       = Berg::VERSION
  spec.authors       = ["Linus Oleander"]
  spec.email         = ["linus@oleander.nu"]

  spec.summary       = "Find paths and values in complex Ruby hashes – much like css selectors"
  spec.description   = "Find paths and values in complex Ruby hashes – much like css selectors"
  spec.homepage      = "http://github.com/oleander/berg"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters"
end
