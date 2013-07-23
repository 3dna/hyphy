require "spec_helper"

describe Swaggie::AbstractORMAdapter do

  describe ".log_sql" do

    let(:sql) { 'select * from heros' }
    let(:start_time) { 1.0001 }
    let(:end_time) { 1.0002 }

    it 'creates a new SQLStatement row' do
      Swaggie::AbstractORMAdapter.log_sql(sql,
                                          start_time,
                                          end_time)

      sql_statement = Swaggie::SQLStatement.last
      sql_statement.statement.should == sql
      sql_statement.start_time.should == start_time
      sql_statement.end_time.should == end_time
    end

  end

end
