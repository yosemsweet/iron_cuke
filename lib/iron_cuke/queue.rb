require "iron_cuke/queue_item"

module IronCuke
	module Queue
	
		def queued
			worker_queue.values.map { |worker| worker.map { |data| data.worker } }.flatten
		end
	
		def queue(worker, options)
			options = options.merge(:priority => 0)
			raise NotImplementedError unless (0..2).include? options[:priority]
		
			worker_queue[options[:priority]] ||= []
			item = IronCuke::QueueItem.new(worker, options)
			worker_queue[options[:priority]] << item
			worker.task_id = item.id
			response = IronCuke::Queue.create_response(item)
		end
	
		def clear_queue
			worker_queue.clear
		end
	
		protected
	
		def worker_queue
			@worker_queue ||= Hash.new
		end
	
		def self.create_response(item)
			{
			    "msg" => "Tasks",
			    "tasks" => [
			        {
			            "id" => item.id
			        }
			    ],
			    "status_code" => 200
			}
		end
	end
end