require 'spec_helper'

describe Hyphy::Filters::LimitFilter do

  before(:each) do
    @limit = 3
    @data = [0, 1, 2, 3]
  end

  describe "#filter" do

    it 'strips the data to a length of the specified limit' do
      limit_filter = Hyphy::Filters::LimitFilter.new(@data, :limit => @limit)
      limit_filter.filter

      limit_filter.data.should == [0, 1, 2]
    end

  end

end
