# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'i18n/laf/version'

Gem::Specification.new do |spec|
  spec.name          = "i18n-laf"
  spec.version       = I18n::LaF::VERSION
  spec.authors       = ["pinzolo"]
  spec.email         = ["pinzolo@gmail.com"]
  spec.description   = %q{This provides a feature that finds lost keys in your I18N dictionary files.}
  spec.summary       = %q{Finder of lost keys in dictionary files}
  spec.homepage      = "https://github.com/pinzolo/i18n-laf"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "coveralls"
end
