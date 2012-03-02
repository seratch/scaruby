# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scaruby/version"

Gem::Specification.new do |s|
  s.name        = "scaruby"
  s.version     = Scaruby::VERSION
  s.authors     = ["Kazuhiro Sera"]
  s.email       = ["seratch@gmail.com"]
  s.homepage    = "https://github.com/seratch/scaruby"
  s.summary     = %q{Scala API in Ruby}
  s.description = %q{Scala API in Ruby}

  s.rubyforge_project = "scaruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
