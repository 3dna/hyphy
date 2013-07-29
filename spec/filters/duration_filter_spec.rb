require 'spec_helper'

describe Hyphy::DurationFilter do

  let!(:sql_statement1) { Hyphy::SQLStatement.create(:statement => 'select count(*) from table1',
                                                     :start_time => 1.0,
                                                     :end_time => 1.1) }

  let!(:sql_statement2) { Hyphy::SQLStatement.create(:statement => 'select count(*) from table2',
                                                     :start_time => 2.0,
                                                     :end_time => 2.1) }

  let!(:sql_statement3) { Hyphy::SQLStatement.create(:statement => 'select count(*) from table3',
                                                     :start_time => 2.0,
                                                     :end_time => 3.0) }

  let!(:sql_statement4) do
    statement = Hyphy::SQLStatement.create(:statement => 'select count(*) from table4',
                                           :start_time => 3.0,
                                           :end_time => 10.0)
    statement.add_metadata('benchmark_time', 7)
    statement
  end

  let(:dataset) { Hyphy::Dataset.new }

  describe "#filter" do

    it 'only returns the sql statements that last longer than one second' do
      dataset.apply_filter(Hyphy::DurationFilter, :duration_min => 1.0)

      dataset.data.should == [sql_statement4, sql_statement3]
    end

    it 'returns the sql statements that have a benchmark time longer than one second' do
      dataset.apply_filter(Hyphy::DurationFilter,
                           :benchmark => true,
                           :duration_min => 1.0)

      dataset.data.should == [sql_statement4]
    end

  end

end
