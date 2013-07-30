require 'spec_helper'

describe Hyphy::DurationFilter do

  before(:each) do
    @sql_statement1 = Hyphy::SQLStatement.new(:statement => 'select count(*) from table1',
                                              :start_time => 1.0,
                                              :end_time => 1.1)

    @sql_statement2 = Hyphy::SQLStatement.new(:statement => 'select count(*) from table2',
                                              :start_time => 2.0,
                                              :end_time => 2.1)

    @sql_statement3 = Hyphy::SQLStatement.new(:statement => 'select count(*) from table3',
                                              :start_time => 2.0,
                                              :end_time => 3.0)

    @sql_statement4 = Hyphy::SQLStatement.new(:statement => 'select count(*) from table4',
                                              :start_time => 3.0,
                                              :end_time => 10.0)
    @sql_statement4.metadata['benchmark_time'] = 7

    @sampler = Hyphy::Sampler.new
    @sampler.dataset = [@sql_statement1, @sql_statement2, @sql_statement3, @sql_statement4]
  end

  describe "#filter" do

    it 'only returns the sql statements that last longer than one second' do
      @sampler.apply_filter(Hyphy::DurationFilter, :duration_min => 1.0)

      @sampler.dataset.should == [@sql_statement4, @sql_statement3]
    end

    it 'returns the sql statements that have a benchmark time longer than one second' do
      @sampler.apply_filter(Hyphy::DurationFilter,
                           :benchmark => true,
                           :duration_min => 1.0)

      @sampler.dataset.should == [@sql_statement4]
    end

  end

end
