require 'spec_helper'

describe Hyphy::LimitFilter do

  before(:each) do
    @limit = 3
    @data = [0, 1, 2, 3]
    @dataset = Hyphy::Dataset.new(@data)
  end

  describe "#filter" do

    it 'strips the dataset to a length of the specified limit' do
      limit_filter = Hyphy::LimitFilter.new(@dataset, :limit => @limit)
      limit_filter.filter

      limit_filter.dataset.data.should == [0, 1, 2]
    end

  end

end
