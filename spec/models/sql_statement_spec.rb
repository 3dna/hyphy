require "spec_helper"

describe Hyphy::SQLStatement do

  let(:statement) { '  select * from table   ' }
  let(:sql_statement) { Hyphy::SQLStatement.new(:statement => statement,
                                                :start_time => 2,
                                                :end_time => 3.001) }

  describe "#duration" do

    it "returns the duration of the statement" do
      sql_statement.duration.should == 1.001
    end

  end

  describe "#stripped_description" do

    it 'strips leading and trailing whitespace' do
      sql_statement.stripped_statement.should == 'select * from table'
    end

  end

  describe "#digitless" do

    let(:statement) { 'select * from table where id = 44444' }
    let(:sql_statement) { Hyphy::SQLStatement.new(:statement => statement,
                                                  :start_time => 2,
                                                  :end_time => 3.001) }

    it 'replaces numbers with a marker' do
      sql_statement.digitless.should == 'select * from table where id = <digit>'
    end

  end

end
