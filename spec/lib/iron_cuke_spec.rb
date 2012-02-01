require 'spec_helper'

describe IronCuke do
	it { should respond_to(:run) }
  
	it { should respond_to(:schedule).with(2).arguments }
	it { should respond_to(:schedules) }
	it { should respond_to(:cancel_schedule).with(1).argument }

	context "::schedule" do
		context "with start_at and run_once schedule options" do
		  it "should add a worker to schedules" do
				worker = TestWorker.new

				#expect not working here - revisit later
				scheduled_count = IronCuke.schedules.count
				IronCuke.schedule(worker, {:start_at => Time.now + 1.year, :run_times => 1})
				IronCuke.schedules.count.should == scheduled_count +  1
			end		  
		end
	end
	
	context "::schedules" do
		it "should return all scheduled workers" do
		  workers = [TestWorker.new, TestWorker.new, TestWorker.new]
			workers.each do |w|
				IronCuke.schedule(w, {:start_at => Time.now + 1.year, :run_times => 1})
			end

			scheduled = IronCuke.schedules
			workers.each do |w|
				scheduled.should include w
			end
		end
	end
end