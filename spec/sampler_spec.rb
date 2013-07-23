require 'spec_helper'

describe Swaggie::Sampler do

  let(:sampler) { Swaggie::Sampler.new }

  describe '#initialize' do

    it 'defaults to an ActiveRecord ORM' do
      sampler.orm_adapter.should == Swaggie::ActiveRecordAdapter
    end

    it "throws an exception for unsupported ORMs" do
      expect{ Swaggie::Sampler.new :orm => :datamapper }
        .to raise_error(Swaggie::Sampler::UnsupportedORMException)
    end

  end

  describe "#begin" do

    it "subscribes to SQL notifications" do
      sampler.orm_adapter.should_receive(:subscribe_to_sql_notifications)
      sampler.begin
    end

  end

end
