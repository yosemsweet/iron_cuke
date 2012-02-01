require 'spec_helper'

describe IronCuke do
  it { should respond_to(:schedule).with(2).arguments }
end