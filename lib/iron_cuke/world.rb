require 'iron_cuke'

#make cucumber aware of IronCuke
World(IronCuke)

#IronCuke will run after each step for scenarios or features tagged with @ironcuke
AfterStep(@ironcuke) do |step|
	IronCuke.run
end