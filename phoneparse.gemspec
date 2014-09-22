# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phoneparse/version'

Gem::Specification.new do |spec|
  spec.name          = "phoneparse"
  spec.version       = Phoneparse::VERSION
  spec.authors       = ["Hugo Lantaume"]
  spec.email         = ["hugolantaume+phoneparse@gmail.com"]
  spec.summary       = %q{A phone validation, formatting and parsing Ruby gem.}
  spec.description   = ""
  spec.homepage      = "https://github.com/hugolantaume/phoneparse"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "phony", "~> 2.4"
  spec.add_dependency "phonelib", "~> 0.3"
  spec.add_dependency "countries", "~> 0.9"
  spec.add_dependency "geocoder", "~> 1.2"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "coveralls"
end
