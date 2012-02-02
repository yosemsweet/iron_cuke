require "iron_worker/base"

#TODO: This should probably be an implementation of an IronWorker::Service (say a TestService) and then we would simply 
# 			change IronWorker.service to return our test service. But modifying IronWorker::Base is a little faster and we
# 			don't need to test IronWorker itself. Just its inputs and outputs. 
module IronWorker
	class Base
		def schedule(options)
			@response = IronCuke.schedule(self, options)
			@schedule_id = "foo" #TODO: This needs to get set properly
		end
	end
end