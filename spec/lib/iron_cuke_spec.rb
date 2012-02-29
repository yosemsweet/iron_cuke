require 'spec_helper'

describe IronCuke do
	it { should respond_to(:run) }
	
	it { should respond_to(:queue).with(2).arguments }
	it { should respond_to(:queued) }
  
	it { should respond_to(:schedule).with(2).arguments }
	it { should respond_to(:schedules) }
	it { should respond_to(:cancel_schedule).with(1).argument }

	context "::queue" do
		after(:each) do
			IronCuke.clear
		end
		
		context "with empty options" do
			let!(:options) { {} }
			
		  it "should add a worker to queued" do
		    worker = TestWorker.new
		
				expect {
					IronCuke.queue(worker, options)
				}.to change{IronCuke.queued.count}.by(1)
		  end
		
			it "should return a response hash include status_code and list of task_ids" do
			  worker = TestWorker.new
				response = IronCuke.queue(worker, options)
				response.should have_key "status_code"
				response.should have_key "tasks"
				response["tasks"].each do |s| s.should have_key "id" end
			end
		end	  
		
		context "with a priority" do
			let(:priority) { 1 }
			let!(:options) { {:priority => priority} }
			
		  it "should add a worker to queued with the same priority" do
		    worker = TestWorker.new
		
				expect {
					IronCuke.queue(worker, options)
				}.to change{IronCuke.queued(priority).count}.by(1)
		  end
		
			it "should return a response hash include status_code and list of task_ids" do
			  worker = TestWorker.new
				response = IronCuke.queue(worker, options)
				response.should have_key "status_code"
				response.should have_key "tasks"
				response["tasks"].each do |s| s.should have_key "id" end
			end
		end
	end

	context "::schedule" do
		after(:each) do
			IronCuke.clear
		end
		
		context "with start_at and run_once schedule options" do
		  it "should add a worker to schedules" do
				worker = TestWorker.new

				expect {
					IronCuke.schedule(worker, {:start_at => Time.now + 1.year, :run_times => 1})
				}.to change{IronCuke.schedules.count}.by(1)
			end
			
			it "should return a response hash include status_code and list of scheduled_ids" do
			  worker = TestWorker.new
				response = IronCuke.schedule(worker, {:start_at => Time.now, :run_times => 1})
				response.should have_key "status_code"
				response.should have_key "schedules"
				response["schedules"].each do |s| s.should have_key "id" end
			end
		end
		
		context "scheduling two workers at the same time" do
		  it "should schedule them both" do
		    worker_one, worker_two = [TestWorker.new, TestWorker.new]
				time = Time.now
				expect {
					IronCuke.schedule(worker_one, {:start_at => time, :run_times => 1})
					IronCuke.schedule(worker_two, {:start_at => time, :run_times => 1})
				}.to change{IronCuke.schedules.count}.by(2)
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
	
	context "::cancel_schedule" do
		let!(:worker) { TestWorker.new }
		
		before(:each) do
			IronCuke.schedule(worker, {:start_at => Time.now + 1.year, :run_times => 1})
		end
		
		after(:each) do
			IronCuke.clear
		end

		context "with a schedule_id that is currently scheduled" do
		  it "should reduce the number of workers in schedules" do
				expect {
					IronCuke.cancel_schedule(worker.schedule_id)
				}.to change{IronCuke.schedules.count}.by(-1)
			end
			
			it "should cause worker to no longer be included in schedules" do
				IronCuke.schedules.should include worker
				IronCuke.cancel_schedule(worker.schedule_id)
				IronCuke.schedules.should_not include worker
			end
		end
	
	end
	
	context "::run" do
		context "with scheduled workers" do
			let(:current_time) { Time.now }
			let!(:past_worker) { TestWorker.new }
			let!(:present_worker) { TestWorker.new }
			let!(:future_worker) { TestWorker.new }
			
			before(:each) do
				IronCuke.schedule(past_worker, {:start_at => current_time - 1.second, :run_times => 1})
				IronCuke.schedule(present_worker, {:start_at => current_time, :run_times => 1})
				IronCuke.schedule(future_worker, {:start_at => current_time + 1.second, :run_times => 1})
			end
		
			after(:each) do
				IronCuke.clear
			end
		
			it "should call run for each worker with a start at time before or equal to Time.now" do
				past_worker.should_receive(:run_local)
				present_worker.should_receive(:run_local)
				IronCuke.run(:time => current_time)
			end
		
			it "should not call run for each worker with a start at time after Time.now" do
				future_worker.should_not_receive(:run_local)
				IronCuke.run(:time => current_time)
			end	
		end
		context "with queued workers" do
			let(:high_priority) { 2 }; let(:medium_priority) { 1 }; let(:low_priority) { 0 }
			let!(:high_priority_worker) { TestWorker.new }
			let!(:medium_priority_worker) { TestWorker.new }
			let!(:low_priority_worker) { TestWorker.new }
			
			before(:each) do
				IronCuke.queue(high_priority_worker, {:priority => high_priority})
				IronCuke.queue(medium_priority_worker, {:priority => medium_priority})
				IronCuke.queue(low_priority_worker, {:priority => low_priority})
			end
		
			after(:each) do
				IronCuke.clear
			end
		
			context "with no priority specified" do
				it "should call run for all workers" do
					high_priority_worker.should_receive(:run_local)
					medium_priority_worker.should_receive(:run_local)
					low_priority_worker.should_receive(:run_local)
					IronCuke.run()
				end
			end
			
			context "with a priority" do
				let(:priority) { medium_priority}
				it "should call run for all workers of that priority or higher" do
					high_priority_worker.should_receive(:run_local)
					medium_priority_worker.should_receive(:run_local)
					IronCuke.run(:priority => priority)
				end
				
				it "should not call run for all workers with less than that priority" do
					low_priority_worker.should_not_receive(:run_local)
					IronCuke.run(:priority => priority)
				end
			end

		end
	end
end