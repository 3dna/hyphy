require 'spec_helper'

describe Swaggie::AbstractFilter do

  it 'stores a dataset' do
    dataset = [1, 2]
    filter = Swaggie::AbstractFilter.new(dataset)

    filter.dataset.should == dataset
    filter.filter.should == dataset
  end

end
