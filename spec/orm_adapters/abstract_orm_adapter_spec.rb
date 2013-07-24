require "spec_helper"

describe Hyphy::AbstractORMAdapter do

  describe ".log_sql" do

    let(:sql) { 'select * from heroes' }
    let(:start_time) { 1.0001 }
    let(:end_time) { 1.0002 }

    it 'creates a new SQLStatement row' do
      Hyphy::AbstractORMAdapter.log_sql(sql,
                                          start_time,
                                          end_time)

      sql_statement = Hyphy::SQLStatement.last
      sql_statement.statement.should == sql
      sql_statement.start_time.should == start_time
      sql_statement.end_time.should == end_time
      sql_statement.trace.class.should == Array
    end

  end

end
