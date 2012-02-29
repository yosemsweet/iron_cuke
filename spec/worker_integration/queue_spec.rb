require 'spec_helper'
require 'iron_cuke/test_service'

IronWorker.configure do |config|
    config.token = 'IRON_WORKER_TOKEN'
    config.project_id = 'IRON_WORKER_PROJECT_ID'
end

IronWorker.service.instance_eval do
	extend IronWorker::TestService::Queue
end

describe "IronWorker::Base.queue" do
	let!(:worker) { TestWorker.new }
	
  it "should add the worker to IronCuke.queue" do
		expect {
			worker.queue()
		}.to change{IronCuke.queued.count}.by(1)
  end

  it "should set worker.response" do
		expect {
			worker.queue()
		}.to change{worker.response}
  end

  it "should set worker.task_id" do
		expect {
			worker.queue()
		}.to change{worker.task_id}
		
		worker.task_id.should_not be_nil
  end

	it "should add a worker with the same task id in to IronCuke.queue" do
		worker.queue()
		
		IronCuke.queued.select { |w| w.task_id == worker.task_id }.should_not be_empty
	end

	context "response" do
	  let(:response) { worker.queue() }
		it { response["status_code"].should == 200 }
		it { response.should have_key "tasks" }
		it { response["tasks"].should be_kind_of Array }
		it { response["tasks"][0].should have_key "id" }
		it { response["tasks"][0]["id"].should_not be_nil }
	end
	
	context "with options" do
	  context "with a priority" do
	    context "with valid priorities" do
	      valid_priorities = (0..2)
				valid_priorities.each do |priority|
					context "with priority #{priority}" do
						let!(:options) { { :priority => priority} }
						
						it "queues the worker in priority #{priority}" do
							lower_priority = [valid_priorities.min, priority - 1].max
							higher_priority = [valid_priorities.max, priority + 1].min
							
							expect {
								worker.queue(options)
							}.to change{ IronCuke.queued(priority).count}.by(1) # and to_not change{ IronCuke.queued(lower_priority).count }
						end					  
					end
				end
	    end
	  end
	end

end