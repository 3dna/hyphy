require 'spec_helper'

describe Hyphy::AbstractFilter do

  it 'stores a dataset' do
    dataset = [1, 2]
    filter = Hyphy::AbstractFilter.new(dataset)

    filter.dataset.should == dataset
    filter.filter.should == dataset
  end

end
