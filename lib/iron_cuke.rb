require "iron_cuke/version"
require 'digest/md5'

class QueueItem
	attr_accessor :worker, :options, :id
	def initialize(worker, options)
		@worker = worker
		@options = options
		@id = Digest::MD5.hexdigest(self.worker.to_s + self.options.to_s)
	end
end


module ScheduledQueue
	
	def schedules
		scheduledQueue.values.map { |data| data.worker }
	end
	
	def schedule(worker, schedule_options)
		scheduledQueue[schedule_options[:start_at]] = QueueItem.new(worker, schedule_options)
	end
	
	def cancel_schedule(scheduled_task_id)
		
	end
	
	protected
	def scheduledQueue
		@scheduledQueue ||= Hash.new
	end
end

module IronCuke
	extend ScheduledQueue
	
	def self.run
	end	
end
