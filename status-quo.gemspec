# -*- encoding: utf-8 -*-
require File.expand_path("../lib/status_quo/version", __FILE__)

Gem::Specification.new do |gem|
  gem.author        = "Bram Engel"
  gem.email         = "engelenburg1980@gmail.com"
  gem.summary       = %q{Monitor the status of your application. Send alerts and visualize the application status over time}
  gem.description   = %q{Monitor the status of your application. Send alerts and visualize the application status over time}
  gem.homepage      = "https://github.com/solid5nake/status-quo"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "status-quo"
  gem.require_paths = ["lib"]
  gem.version       = StatusQuo::VERSION
  gem.licenses      = ["MIT"]

  gem.add_dependency "activerecord", ">= 3.2.13"
  gem.add_dependency "actionmailer"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "yard"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "mysql2", "~> 0.3.18"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "minitest"
  gem.add_development_dependency "mocha"
  gem.add_development_dependency "fakeweb", "~> 1.3"
end
