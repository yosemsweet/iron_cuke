require "iron_cuke/version"
require "iron_cuke/scheduled_queue"
require "iron_cuke/queue"
require "iron_cuke/test_service"


module IronCuke
	extend IronCuke::ScheduledQueue
	extend IronCuke::Queue
	
	class << self
		
		def run(*args)
			options = {:time => Time.now, :priority => 0}
			options.merge! args.pop if args.last.is_a? Hash
			run_scheduled_workers(options[:time])
			run_queued(options[:priority])
		end	
	
		def clear
			clear_queue
			clear_schedules
		end
		
		def run_scheduled_workers(time)
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
		
		def run_queued(priority)
			to_execute = worker_queue.keys.select { |p| p >= priority }
			to_execute.sort{|x,y| y <=> x }.each do |p|
				begin
					worker_queue[p].each { |data| data.worker.run_local }
					worker_queue.delete(p)
				rescue Exception => e
					puts e
				end
			end
		end
		
	end
	
end
