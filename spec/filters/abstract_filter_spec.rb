require 'spec_helper'

describe Hyphy::AbstractFilter do

  it 'stores data' do
    data = [1, 2]
    filter = Hyphy::AbstractFilter.new(data)

    filter.data.should == data
    filter.filter.should == data
  end

end
