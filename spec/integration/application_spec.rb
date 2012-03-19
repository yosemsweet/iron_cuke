require 'spec_helper'

describe 'Application sanity checks' do
  
	context "for Rails.application" do
		subject { Rails.application }
		it {should be_kind_of Dummy::Application}
	end
	
	context "has ore" do
	  subject { Ore.new }
		it { should respond_to(:size) }
		it { should respond_to(:size=) }
	end

end