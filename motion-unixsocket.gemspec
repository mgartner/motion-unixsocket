# -*- encoding: utf-8 -*-
require File.expand_path('../lib/unix/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Marcus Gartner"]
  gem.email         = ["magartner@gmail.com"]
  gem.description   = "A Unix domain socket library for RubyMotion."
  gem.summary       = "A Unix domain socket library for RubyMotion."
  gem.license       = "MIT"
  gem.homepage      = "https://github.com/mgartner/motion-unixsocket"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "motion-unixsocket"
  gem.require_paths = ["lib"]
  gem.version       = UNIX::VERSION

  gem.add_development_dependency 'rake'
  gem.add_dependency 'motion.h', '~> 0.0.4'
end
