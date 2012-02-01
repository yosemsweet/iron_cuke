require "require_all"
require_all "lib"

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}