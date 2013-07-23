require 'spec_helper'

describe Swaggie::DurationFilter do

  let!(:sql_statement1) { Swaggie::SQLStatement.create(:statement => 'select count(*) from table1',
                                                       :start_time => 1.0,
                                                       :end_time => 1.1) }

  let!(:sql_statement2) { Swaggie::SQLStatement.create(:statement => 'select count(*) from table2',
                                                       :start_time => 2.0,
                                                       :end_time => 2.1) }

  let!(:sql_statement3) { Swaggie::SQLStatement.create(:statement => 'select count(*) from table3',
                                                       :start_time => 2.0,
                                                       :end_time => 3.0) }

  let!(:sql_statement4) { Swaggie::SQLStatement.create(:statement => 'select count(*) from table4',
                                                       :start_time => 3.0,
                                                       :end_time => 10.0) }

  let(:dataset) { Swaggie::Dataset.new }

  describe "#filter" do

    it 'only returns the sql statements that last longer than one second' do
      dataset.get_data
      dataset.apply_filter(Swaggie::DurationFilter)

      dataset.data.should == [sql_statement4, sql_statement3]
    end

  end

end
