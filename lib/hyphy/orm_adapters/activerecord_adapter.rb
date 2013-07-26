require 'active_record'
require 'active_support/notifications'
require 'benchmark'

class Hyphy::ActiveRecordAdapter < Hyphy::AbstractORMAdapter

  def self.subscribe_to_sql_notifications(callback)
    ActiveSupport::Notifications.subscribe('sql.active_record') do |*args|
      sql_statement = args[4][:sql]
      start_time = args[1]
      end_time = args[2]

      callback.call(sql_statement, start_time, end_time, self)
    end
  end

  def self.unsubscribe_to_sql_notifications(subscriber)
    ActiveSupport::Notifications.unsubscribe(subscriber)
  end

  def self.time_statement(statement)
    Benchmark.realtime { ActiveRecord::Base.connection.execute(statement) }
  end

end
