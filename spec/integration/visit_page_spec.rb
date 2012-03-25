require 'spec_helper'

describe "Visit pages" do
  
	describe "visit homepage" do
		it "should not generate an error" do
			expect {
				visit "/"
			}.to_not raise_error
		end
	end

end