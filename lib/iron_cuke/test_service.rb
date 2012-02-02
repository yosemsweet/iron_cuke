require "iron_cuke"
require "base64"
require "json"

module IronWorker
	class Base
		def upload_if_needed(options) :uploaded_successfully end
	end
	
	module TestService
		module Schedule
			def schedule(name, data, options)
				worker = name.classify.constantize.new
				variables = JSON.parse(Base64.decode64(data[:attr_encoded])) if data[:attr_encoded].present?
				variables.each do |k, v|
					worker.instance_variable_set(k.to_sym, v)
				end
				IronCuke.schedule(worker, options)
			end
		end
	end
end
