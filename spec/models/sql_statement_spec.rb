require "spec_helper"

describe Swaggie::SQLStatement do

  describe "#duration" do

    let(:sql_statement) { Swaggie::SQLStatement.new(:start_time => 2,
                                                    :end_time => 3.001) }

    it "returns the duration of the statement" do
      sql_statement.duration.should == 1.001
    end

  end

end
