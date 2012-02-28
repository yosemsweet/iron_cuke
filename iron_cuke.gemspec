# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "iron_cuke/version"

Gem::Specification.new do |s|
  s.name        = "iron_cuke"
  s.version     = IronCuke::VERSION
  s.authors     = ["Yosem Sweet"]
  s.email       = ["yosem.sweet@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A small gem to help you mock out iron worker while using cucumber}
  s.description = %q{iron_cuke provides a set of steps and Cucumber world objects you can use to simulate IronWorker while running cucumber tests.}

  s.rubyforge_project = "iron_cuke"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
	s.add_dependency "iron_worker"
	s.add_dependency "cucumber", ">=0.8"
	s.add_dependency "json"

	s.add_development_dependency "rack"
	s.add_development_dependency "bundler"
	s.add_development_dependency "git"
	s.add_development_dependency "rspec-rails", "~>2.8.0"
	s.add_development_dependency "rails", "~>3.1.0"
	s.add_development_dependency "cucumber-rails"
	s.add_development_dependency "ruby-debug19"
end
