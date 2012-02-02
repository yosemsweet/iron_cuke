require "iron_worker"

class TestWorker < IronWorker::Base
	attr_reader :foo
	
	def initialize()
		@foo = "bar"
	end
	
  def run
		log = Logger.new("iron_cuke.log", 1, 10240)
		log.info "Test worker run " + self.inspect
  end

end