require 'rubygems'
require 'active_support/core_ext'
require 'ruby-debug' unless ENV["CI"]

Dir[File.dirname(__FILE__) + ("/support/**/*.rb")].each {|f| require f}

require "iron_cuke"