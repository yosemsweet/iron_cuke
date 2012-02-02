require 'spec_helper'

IronWorker.configure do |config|
    config.token = 'IRON_WORKER_TOKEN'
    config.project_id = 'IRON_WORKER_PROJECT_ID'
end

describe "IronWorker::Base.schedule" do
	let!(:worker) { TestWorker.new }
	
  it "should add the worker to IronCuke.schedules" do
		worker.schedule(:start_at => Time.now, :run_times => 1)
		# 	
		#     expect {
		# 	worker.schedule(:start_at => Time.now, :run_times => 1)
		# }.to change{IronCuke.schedules.count}.by(1)
  end
end