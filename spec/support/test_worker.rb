require "iron_worker/base"

class TestWorker < IronWorker::Base

  def run
		puts "Test worker run"
		puts " in Local environment" if self.is_local?
  end

end