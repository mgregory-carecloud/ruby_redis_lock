# encoding: utf-8
require 'simplecov'
SimpleCov.start do
  coverage_dir("coverage") 
end

require 'rspec'

require File.expand_path("../../lib/ruby_redis_lock",__FILE__)

require 'spec_config.rb'