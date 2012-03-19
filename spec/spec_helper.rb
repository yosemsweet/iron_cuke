require 'rubygems'
require 'active_support/core_ext'
require 'ruby-debug' unless ENV["CI"]

Dir[File.dirname(__FILE__) + ("/support/**/*.rb")].each {|f| require f}

require "iron_cuke"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'capybara/rspec'
require 'rspec/rails'