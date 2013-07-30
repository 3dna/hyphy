require 'spec_helper'

describe Hyphy::Filters::SQLFilter do

  before(:each) do
    @sql_statement1 = Hyphy::SQLStatement.new(:statement => "select * from table")
    @sql_statement2 = Hyphy::SQLStatement.new(:statement => "insert into table values 1, 2, 3")
    @data = [@sql_statement1, @sql_statement2]
  end

  describe "#initialize" do

    it "throws an exception when an incorrect SQL statement type is provided" do
      expect { Hyphy::Filters::SQLFilter.new(@data, :type => :lol) }
        .to raise_error(Hyphy::Filters::SQLFilter::IncorrectSQLTypeException)
    end

  end

  describe "#filter" do

    it "filters the data to include SQL statements of the right type" do
      sql_filter = Hyphy::Filters::SQLFilter.new(@data, :type => :select)
      sql_filter.filter

      @data.should == [@sql_statement1]
    end

  end

end
