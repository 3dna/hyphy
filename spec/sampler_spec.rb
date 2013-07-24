require 'spec_helper'

describe Hyphy::Sampler do

  describe ".begin" do

    it "subscribes to SQL notifications" do
      Hyphy::ActiveRecordAdapter.should_receive(:subscribe_to_sql_notifications)
      Hyphy::Sampler.begin
    end

    it "throws an exception for unsupported ORMs" do
      expect{ Hyphy::Sampler.begin :orm => :datamapper }
        .to raise_error(Hyphy::Sampler::UnsupportedORMException)
    end

  end

end
