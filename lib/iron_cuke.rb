require "iron_cuke/version"

module IronCuke
	#
	# schedule: hash of scheduling options that can include:
	#     Required:
	#     - start_at:      Time of first run - DateTime or Time object.
	#     Optional:
	#     - run_every:     Time in seconds between runs. If ommitted, task will only run once.
	#     - delay_type:    Fixed Rate or Fixed Delay. Default is fixed_delay.
	#     - end_at:        Scheduled task will stop running after this date (optional, if ommitted, runs forever or until cancelled)
	#     - run_times:     Task will run exactly :run_times. For instance if :run_times is 5, then the task will run 5 times.
	#
	def self.schedule(worker, schedule)
		
	end
end
