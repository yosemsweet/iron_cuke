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

end