require 'json'

require "spec_helper"

describe Hyphy::SQLStatement do

  let(:statement) { '  select * from table   ' }
  let(:sql_statement) { Hyphy::SQLStatement.new(:statement => statement,
                                                :start_time => 2,
                                                :end_time => 3.001,
                                                :trace_json => JSON(["hello!"])) }

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

  describe "#trace" do

    it 'should return the decoded json stored in the trace_json attribute' do
      sql_statement.trace.should == ["hello!"]
    end

  end

  describe ".truncate_table" do

    it 'should clear all sql_statements rows' do
      Hyphy::SQLStatement.create
      Hyphy::SQLStatement.all.count.should == 1

      Hyphy::SQLStatement.truncate_table
      Hyphy::SQLStatement.all.count.should == 0
    end

  end

end
