require 'spec_helper'

describe Swaggie::Sampler do

  describe ".begin" do

    it "subscribes to SQL notifications" do
      Swaggie::ActiveRecordAdapter.should_receive(:subscribe_to_sql_notifications)
      Swaggie::Sampler.begin
    end

    it "throws an exception for unsupported ORMs" do
      expect{ Swaggie::Sampler.begin :orm => :datamapper }
        .to raise_error(Swaggie::Sampler::UnsupportedORMException)
    end

  end

end
