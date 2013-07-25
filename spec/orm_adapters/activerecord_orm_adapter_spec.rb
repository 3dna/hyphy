require "spec_helper"

describe Hyphy::ActiveRecordAdapter do

  let(:sql_statement) { 'select count(*) from victims' }
  let(:start_time) { 1.0001 }
  let(:end_time) { 1.0002 }

  describe ".subscribe_to_sql_notifications" do

    it "should catch sql.active_record notifications" do
      ActiveSupport::Notifications.should_receive(:subscribe)
        .and_yield(nil, start_time, end_time, nil, { :sql => sql_statement })

      callback = lambda { |a, b, c| }

      Hyphy::ActiveRecordAdapter.subscribe_to_sql_notifications(callback)
    end

  end

  describe ".unsubscribe_to_sql_notifications" do

    it "unsubscribes subscriber notifications from ActiveSupport"do
      subscriber = double()
      ActiveSupport::Notifications.should_receive(:unsubscribe)
        .with(subscriber)

      Hyphy::ActiveRecordAdapter.unsubscribe_to_sql_notifications(subscriber)
    end

  end

end
