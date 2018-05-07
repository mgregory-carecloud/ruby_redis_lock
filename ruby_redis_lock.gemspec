# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ruby_redis_lock/version"

Gem::Specification.new do |spec|
  spec.name        = "ruby_redis_lock"
  spec.version     = RubyRedisLock::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ["Tanin Na Nakorn", "Mike Gregory"]
  spec.email       = ["tanin47@yahoo.com", "mgregory@carecloud.com"]
  spec.homepage    = "http://github.com/mgregory-carecloud/ruby_redis_lock"
  spec.license       = "MIT"
  
  spec.summary     = %q{RubyRedisLock is a distributed lock for Ruby (using Redis)}
  spec.description = %q{distributed lock for Ruby (using Redis)}

  spec.rubyforge_project = "ruby_redis_lock"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {coverage,spec}/**/*_spec.rb`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

end
