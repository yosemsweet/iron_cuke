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
				expect {
					IronCuke.schedule(worker, {:start_at => Time.now + 1.year, :run_times => 1})
				}.to(:change) { IronCuke.schedules.count }.by(1)
			end		  
		end
	end
end