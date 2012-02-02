require 'spec_helper'

describe IronCuke do
	it { should respond_to(:run) }
  
	it { should respond_to(:schedule).with(2).arguments }
	it { should respond_to(:schedules) }
	it { should respond_to(:cancel_schedule).with(1).argument }

	context "::schedule" do
		after(:each) do
			IronCuke.clear
		end
		
		context "with start_at and run_once schedule options" do
		  it "should add a worker to schedules" do
				worker = TestWorker.new

				#expect not working here - revisit later
				scheduled_count = IronCuke.schedules.count
				IronCuke.schedule(worker, {:start_at => Time.now + 1.year, :run_times => 1})
				IronCuke.schedules.count.should == scheduled_count +  1
			end		  
		end
		context "scheduling two workers at the same time" do
		  it "should schedule them both" do
		    
		  end
		end
	end
	
	context "::schedules" do
		after(:each) do
			IronCuke.clear
		end
		
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
	
	context "::run" do
		let(:current_time) { Time.now }
		before(:each) do
			@past_worker			=  TestWorker.new
			@present_worker		=  TestWorker.new
			@future_worker		=  TestWorker.new
			
			IronCuke.schedule(@past_worker, {:start_at => current_time - 1.second, :run_times => 1})
			IronCuke.schedule(@present_worker, {:start_at => current_time, :run_times => 1})
			IronCuke.schedule(@future_worker, {:start_at => current_time + 1.second, :run_times => 1})			
		end
		
		after(:each) do
			IronCuke.clear
		end
		
		it "should call run for each worker with a start at time before Time.now" do
			@past_worker.should_receive(:run)
			@present_worker.should_receive(:run)
			puts "===== workers ====="
			puts @past_worker
			puts @present_worker
			puts "==================="		
			IronCuke.run(current_time)
		end
	end
end