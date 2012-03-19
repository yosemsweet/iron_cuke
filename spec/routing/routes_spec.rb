require "spec_helper"

describe "routes" do
	get("/").should route_to("homepage#show")
end
