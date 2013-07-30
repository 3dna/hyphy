require 'spec_helper'

describe Hyphy::Sampler do

  let(:sampler) { Hyphy::Sampler.new }
  let(:statement) { 'select * from heroes' }
  let(:start_time) { 1.0001 }
  let(:end_time) { 1.0002 }

  describe "#initialize" do

    it "throws an exception for unsupported ORMs" do
      expect{ Hyphy::Sampler.new :orm => :datamapper }
        .to raise_error(Hyphy::Sampler::UnsupportedORMException)
    end

  end

  describe "#begin" do

    it "subscribes to SQL notifications" do
      Hyphy::ActiveRecordAdapter.should_receive(:subscribe_to_sql_notifications)
      sampler.begin
    end

  end

  describe "#log_sql" do

    it 'creates a new SQLStatement row' do
      sampler.log_sql(statement,
                      start_time,
                      end_time,
                      Hyphy::ActiveRecordAdapter)

      sql_statement = sampler.dataset.last
      sql_statement.statement.should == statement
      sql_statement.start_time.should == start_time
      sql_statement.end_time.should == end_time
      sql_statement.trace.class.should == Array
      sql_statement.orm_adapter.should == Hyphy::ActiveRecordAdapter
    end

  end

  describe "#sample" do

    it "logs the SQL statement and adds metadata" do
      sampler.should_receive(:log_sql).with(statement,
                                            start_time,
                                            end_time,
                                            Hyphy::ActiveRecordAdapter)

      sampler.should_receive(:process_metadata)

      sampler.sample(statement, start_time, end_time)
    end

  end

  describe "#add_metadata" do

    it "stores a block that'll be used for adding metadata to a SQLStatement" do
      sampler.add_metadata("test") { "this is just a test!" }

      sampler.metadata_callbacks["test"].call.should == "this is just a test!"
    end

  end

  describe "#process_metadata" do

    let(:sql_statement) { Hyphy::SQLStatement.new }

    it "adds metadata from a proc to a SQLStatement" do
      sampler.add_metadata("test") { "this is just a test!" }
      sampler.process_metadata(sql_statement)

      sql_statement.metadata.should == { "test" => "this is just a test!" }
    end

  end

  describe "#stop" do

    it 'unsubscribes SQL notifications' do
      subscriber = sampler.begin
      Hyphy::ActiveRecordAdapter.should_receive(:unsubscribe_to_sql_notifications)
        .with(subscriber)

      sampler.stop
    end

  end

  describe "#apply_filter" do

    before(:each) do
      @sampler = Hyphy::Sampler.new
      @sql_statement1 = Hyphy::SQLStatement.new(:statement => "select * from table1",
                                                :start_time => 1.001,
                                                :end_time => 2.002)

      @sql_statement2 = Hyphy::SQLStatement.new(:statement => "select * from table2",
                                                :start_time => 1.001,
                                                :end_time => 3.002)

      @sampler.dataset << @sql_statement1
      @sampler.dataset << @sql_statement2
    end

    it "filters the in memory dataset" do
      @sampler.apply_filter(Hyphy::Filters::DurationFilter, :duration_min => 1.5)
      @sampler.dataset.should == [@sql_statement2]
    end

  end

  describe "#profile" do

    it "starts and stops the sampling"do
      sampler.should_receive(:begin)
      sampler.should_receive(:stop)
      sampler.profile {}
    end

  end

end
