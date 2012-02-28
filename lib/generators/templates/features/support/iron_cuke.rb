require "iron_cuke"

IronWorker.service.instance_eval do
	extend IronWorker::TestService::Schedule
	extend IronWorker::TestService::Queue
end