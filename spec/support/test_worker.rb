require "iron_worker/base"

class TestWorker < IronWorker::Base

  def run
		puts "Test worker run " + self
		puts " in Local environment" if self.is_local?
  end

end