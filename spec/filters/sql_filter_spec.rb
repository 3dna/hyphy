require 'spec_helper'

describe Hyphy::SQLFilter do

  before(:each) do
    @sql_statement1 = Hyphy::SQLStatement.create(:statement => "select * from table")
    @sql_statement2 = Hyphy::SQLStatement.create(:statement => "insert into table values 1, 2, 3")
    @data = [@sql_statement1, @sql_statement2]
  end

  describe "#initialize" do

    it "throws an exception when an incorrect SQL statement type is provided" do
      expect { Hyphy::SQLFilter.new(@data, :type => :lol) }
        .to raise_error(Hyphy::SQLFilter::IncorrectSQLTypeException)
    end

  end

  describe "#filter" do

    it "filters the data to include SQL statements of the right type" do
      sql_filter = Hyphy::SQLFilter.new(@data, :type => :select)
      sql_filter.filter

      @data.should == [@sql_statement1]
    end

  end

end
