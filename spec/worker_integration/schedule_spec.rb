require 'spec_helper'

IronWorker.configure do |config|
    config.token = 'IRON_WORKER_TOKEN'
    config.project_id = 'IRON_WORKER_PROJECT_ID'
end

IronWorker.service.instance_eval do
	extend IronWorker::TestService::Schedule
end

describe "IronWorker::Base.schedule" do
	let!(:worker) { TestWorker.new }
	
  it "should add the worker to IronCuke.schedules" do
		expect {
			worker.schedule(:start_at => Time.now, :run_times => 1)
		}.to change{IronCuke.schedules.count}.by(1)
  end

  it "should set worker.response" do
		pending "There is a bug in IronWorker::Base where the response isn't set"
		expect {
			worker.schedule(:start_at => Time.now, :run_times => 1)
		}.to change{worker.response}
  end

  it "should set worker.schedule_id" do
		expect {
			worker.schedule(:start_at => Time.now, :run_times => 1)
		}.to change{worker.schedule_id}
  end

end