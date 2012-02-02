require "iron_cuke/version"
require "iron_cuke/scheduled_queue"
require "iron_cuke/test_service"


module IronCuke
	extend ScheduledQueue
	
	def self.run(time = nil)
		time ||= Time.now
		to_execute = scheduled_queue.keys.select { |run_at| run_at <= time }
		to_execute.each do |k|
			begin
				scheduled_queue[k].each { |data| data.worker.run_local }
				scheduled_queue.delete(k)
			rescue Exception => e
				puts e
			end
		end
	end	
end
