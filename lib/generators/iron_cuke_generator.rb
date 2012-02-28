require 'rails/generators'

class IronCukeGenerator < Rails::Generators::Base
  desc "Generates Iron Cuke step and support files."

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end

	def create_features_support
		copy_file "features/support/iron_cuke.rb", "features/support/iron_cuke.rb"
	end

	def create_features_step_definitions
		copy_file "features/step_definitions/iron_cuke_steps.rb", "features/step_definitions/iron_cuke_steps.rb"
	end
end