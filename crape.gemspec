# -*- encoding: utf-8 -*-
require File.expand_path('../lib/crape/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Chris Blackburn"]
  gem.email         = ["chris@midwiretech.com"]
  gem.description   = %q{Craigslist Scrape (Crape) will search Craigslist for a set of keywords, print out the results and optionally send an email or text message for each item found}
  gem.summary       = %q{Search Craigslist for stuff and notify over SMS}
  gem.homepage      = "https://github.com/midwire/crape"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "crape"
  gem.require_paths = ["lib"]
  gem.version       = Crape::VERSION

  # specify any dependencies here; for example:
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "guard"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "growl"
  gem.add_development_dependency "rb-fsevent"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "rake"

  gem.add_runtime_dependency "thor"
  gem.add_runtime_dependency "colored"
  gem.add_runtime_dependency "mail"
  gem.add_runtime_dependency "sqlite3"
  gem.add_runtime_dependency "craigler"
  gem.add_runtime_dependency "midwire_common"
end
