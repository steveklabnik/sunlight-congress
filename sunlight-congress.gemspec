# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sunlight/congress/version'

Gem::Specification.new do |spec|
  spec.name          = "sunlight-congress"
  spec.version       = Sunlight::Congress::VERSION
  spec.authors       = ["Steve Klabnik"]
  spec.email         = ["steve@steveklabnik.com"]
  spec.description   = %q{A wrapper for the Sunlight Labs Congress API.}
  spec.summary       = %q{A wrapper for the Sunlight Labs Congress API.}
  spec.homepage      = "https://github.com/steveklabnik/sunlight-congress"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "turn"
end
