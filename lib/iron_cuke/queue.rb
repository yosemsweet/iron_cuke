require "iron_cuke/queue_item"

module IronCuke
	module Queue
	
		def queued(priority = 0)
			raise ArgumentError unless priority.between?(0,2)
			worker_queue.select{|p, workers| p >= priority}.values.map { |p| 
				p.map { |data| 
					data.worker 
				} 
			}.flatten
		end
	
		def queue(worker, options)
			options = {:priority => 0}.merge(options)
			raise NotImplementedError unless options[:priority].between?(0,2)
		
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