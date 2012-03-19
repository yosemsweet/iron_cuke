require 'spec_helper'

describe "Sanity test dummy homepage works" do
  
	describe "visit homepage" do
	  expect {
			visit '/'
		}.to_not raise_error
	end

end