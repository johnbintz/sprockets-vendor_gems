# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors       = ["John Bintz"]
  gem.email         = ["john@coswellproductions.com"]
  gem.description   = %q{Get the vendored assets paths in gems.}
  gem.summary       = %q{Get the vendored assets paths in gems.}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "sprockets-vendor_gems"
  gem.require_paths = ["lib"]
  gem.version       = '0.1.0'

  gem.required_rubygems_version = '1.8.0'
end

