require 'spec_helper'

describe Swaggie::DatasetCollection do

  before(:each) do
    Swaggie::SQLStatement.create :statement => 'select * from table where id = 4'
    Swaggie::SQLStatement.create :statement => 'select * from table where id = 7'
    Swaggie::SQLStatement.create :statement => 'select * from table'
  end

  let(:dataset) { Swaggie::Dataset.new }
  let(:dataset_collection) { Swaggie::DatasetCollection.new(dataset, :statement) }

  describe "#process_dataset" do

    before(:each) { dataset_collection.process_dataset }

    it "creates a collection with each statement having a unique key" do
      dataset_collection.dataset_collection.keys.uniq.count.should == 3
      dataset_collection.dataset_collection.values.uniq.count.should == 3
    end

  end

  describe "#counts_hash" do

    before(:each) { dataset_collection.process_dataset }

    it "maps the correct statements to counts" do
      puts dataset_collection.counts_hash.should ==
        { "select * from table where id = 4" => 1,
          "select * from table where id = 7" => 1,
          "select * from table" => 1 }
    end

  end

end
