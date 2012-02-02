require "iron_cuke/queue_item"

module ScheduledQueue
	
	def schedules
		scheduled_queue.values.map { |scheduled| scheduled.map { |data| data.worker } }.flatten
	end
	
	def schedule(worker, schedule_options)
		Raise NotImplementedError if schedule_options[:run_times] > 1
		
		scheduled_queue[schedule_options[:start_at]] ||= []
		item = QueueItem.new(worker, schedule_options)
		scheduled_queue[schedule_options[:start_at]] << item
		response = create_response(item)
	end
	
	def cancel_schedule(scheduled_task_id)
		Raise NotImplementedError
	end
	
	def clear
		scheduled_queue.clear
	end
	
	protected
	
	def scheduled_queue
		@scheduled_queue ||= Hash.new
	end
	
	def create_response(item)
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