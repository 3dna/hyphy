require "spec_helper"

describe Swaggie::ActiveRecordAdapter do

  let(:sql_statement) { 'select count(*) from victims' }
  let(:start_time) { 1.0001 }
  let(:end_time) { 1.0002 }

  describe ".subscribe_to_sql_notifications" do

    it "should catch sql.active_record notifications" do
      ActiveSupport::Notifications.should_receive(:subscribe)
        .and_yield(nil, start_time, end_time, nil, { :sql => sql_statement })
      Swaggie::ActiveRecordAdapter.should_receive(:log_sql).with(sql_statement,
                                                                 start_time,
                                                                 end_time)

      Swaggie::ActiveRecordAdapter.subscribe_to_sql_notifications
    end

  end

end
