require "iron_cuke/queue_item"

module IronCuke
	module ScheduledQueue
	
		def schedules
			scheduled_queue.values.map { |scheduled| scheduled.map { |data| data.worker } }.flatten
		end
	
		def schedule(worker, schedule_options)
			raise NotImplementedError if schedule_options[:run_times] > 1
		
			scheduled_queue[schedule_options[:start_at]] ||= []
			item = IronCuke::QueueItem.new(worker, schedule_options)
			scheduled_queue[schedule_options[:start_at]] << item
			worker.schedule_id = item.id
			response = IronCuke::ScheduledQueue.create_response(item)
		end
	
		def cancel_schedule(scheduled_task_id)
			scheduled_queue.each { |k,v| v.delete_if{ |data| data.id == scheduled_task_id  } }
		end
	
		def clear_schedules
			scheduled_queue.clear
		end
	
		protected
	
		def scheduled_queue
			@scheduled_queue ||= Hash.new
		end
	
		def self.create_response(item)
			{
			    "msg" => "Scheduled",
			    "schedules" => [
			        {
			            "id" => item.id
			        }
			    ],
			    "status_code" => 200
			}
		end
	end
end