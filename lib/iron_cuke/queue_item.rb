require 'digest/md5'

class QueueItem
	attr_accessor :worker, :options, :id
	def initialize(worker, options)
		@worker = worker
		@options = options
		@id = Digest::MD5.hexdigest(self.worker.inspect + self.options.inspect)
	end
end