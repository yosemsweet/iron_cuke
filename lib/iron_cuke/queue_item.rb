require 'digest/md5'

module IronCuke
	class QueueItem
		attr_reader :worker, :options, :id
		def initialize(worker, options)
			@worker = worker
			@options = options
			@id = Digest::MD5.hexdigest(self.worker.inspect + self.options.inspect)
		end
	end
end