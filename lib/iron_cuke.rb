require "iron_cuke/version"
require 'digest/md5'

class QueueItem
	attr_accessor :worker, :options, :id
	def initialize(worker, options)
		@worker = worker
		@options = options
		@id = Digest::MD5.hexdigest(self.worker.inspect + self.options.inspect)
	end
end


module ScheduledQueue
	
	def schedules
		scheduled_queue.values.map { |scheduled| scheduled.map { |data| data.worker } }.flatten
	end
	
	def schedule(worker, schedule_options)
		Raise "Unimplemented" if schedule_options[:run_times] > 1
		
		scheduled_queue[schedule_options[:start_at]] ||= []
		scheduled_queue[schedule_options[:start_at]] << QueueItem.new(worker, schedule_options)
	end
	
	def cancel_schedule(scheduled_task_id)
		
	end
	
	def clear
		scheduled_queue.clear
	end
	
	protected
	def scheduled_queue
		@scheduled_queue ||= Hash.new
	end
end

module IronCuke
	extend ScheduledQueue
	
	def self.run(time = nil)
		time ||= Time.now
		to_execute = scheduled_queue.keys.select { |run_at| run_at <= time }
		to_execute.each do |k|
			begin
				scheduled_queue[k].each { |data| data.worker.run }
				scheduled_queue.delete(k)
			rescue Exception => e
				puts e
			end
		end
	end	
end
