require 'spec_helper'

describe Hyphy::Filters::BenchmarkFilter do

  before(:each) do
    @sql_statement = Hyphy::SQLStatement.new(:statement => 'select * from table',
                                             :orm_adapter => Hyphy::AbstractORMAdapter)
    @sql_statement_times = [1.0, 2.0, 3.0]
    @runs = @sql_statement_times.count

    Hyphy::AbstractORMAdapter.stub(:time_statement).and_return(*@sql_statement_times)

    @data = [@sql_statement]
    @filter = Hyphy::Filters::BenchmarkFilter.new(@data, :runs => @runs)
    @average_time = @sql_statement_times.reduce(:+) / @runs
  end

  describe "#filter" do

    it "modifies the data to include benchmark data" do
      @filter.filter

      @data[0].benchmark_runs.should == @runs
      @data[0].benchmark_time.should == @average_time
    end

  end

  describe ".benchmark" do

    it "it returns an average of the different run times of a statement" do
      average_time = Hyphy::Filters::BenchmarkFilter.benchmark(@sql_statement, @runs)
      average_time.should == @average_time
    end

  end

end
