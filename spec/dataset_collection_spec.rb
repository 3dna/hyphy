require 'spec_helper'

describe Swaggie::DatasetCollection do

  before(:each) do
    Swaggie::SQLStatement.create :statement => 'select * from table where id = 4'
    Swaggie::SQLStatement.create :statement => 'select * from table where id = 7'
    Swaggie::SQLStatement.create :statement => 'select * from table'
  end

  describe "#process_dataset" do

    let(:dataset) { Swaggie::Dataset.new }

    it "creates a collection with each statement having a unique key" do
      dataset_collection = Swaggie::DatasetCollection.new(dataset, :statement)
      dataset_collection.process_dataset

      dataset_collection.dataset_collection.keys.uniq.count.should == 3
      dataset_collection.dataset_collection.values.uniq.count.should == 3
    end

  end

end
