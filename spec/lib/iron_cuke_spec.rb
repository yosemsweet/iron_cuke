require 'spec_helper'

describe IronCuke do
	it { should respond_to(:run) }
  
	it { should respond_to(:schedule).with(2).arguments }
	it { should respond_to(:schedules) }
	it { should respond_to(:cancel_schedule).with(1).argument }

	context "::schedule" do
	  
	end
end