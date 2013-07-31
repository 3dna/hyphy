require 'spec_helper'

describe Hyphy::Filters::WhitelistedQueriesFilter do

  before(:each) do
    @sql_statement1 = Hyphy::SQLStatement.new(:statement => 'select * from table where id = 3')
    @sql_statement2 = Hyphy::SQLStatement.new(:statement => 'select * from table_x where id = 3')

    @whitelist = ['select * from table where id = <digit>']
  end

  describe "#filter" do

    it "removes the whitelisted query" do
      filter = Hyphy::Filters::WhitelistedQueriesFilter.new([@sql_statement1, @sql_statement2],
                                                            :query_whitelist => @whitelist)
      filter.filter

      filter.data.should == [@sql_statement2]
    end

    it "doesn't filter anything if the whitelist is blank" do
      filter = Hyphy::Filters::WhitelistedQueriesFilter.new([@sql_statement1, @sql_statement2])

      filter.filter

      filter.data.should == [@sql_statement1, @sql_statement2]
    end

  end

end
