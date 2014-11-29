# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ramesh/bot/twitter/version'

Gem::Specification.new do |spec|
  spec.name          = "ramesh-bot-twitter"
  spec.version       = Ramesh::Bot::Twitter::VERSION
  spec.authors       = ["Daisuke Fujita"]
  spec.email         = ["dtanshi45@gmail.com"]
  spec.summary       = %q{Ramesh Twitter bot}
  spec.description   = %q{Ramesh Twitter bot}
  spec.homepage      = "https://github.com/dtan4/ramesh-twitter-bot"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ramesh", "~> 1.4"
  spec.add_dependency "twitter"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
