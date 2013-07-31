require 'active_record'
require 'active_support/notifications'
require 'benchmark'

class Hyphy::ActiveRecordAdapter < Hyphy::AbstractORMAdapter

  def self.subscribe_to_sql_notifications(callback)
    ActiveSupport::Notifications.subscribe('sql.active_record') do |*args|
      sql = args[4][:sql]
      binds = args[4][:binds]
      start_time = args[1]
      end_time = args[2]

      callback.call(sql, start_time, end_time) if binds.empty?
    end
  end

  def self.unsubscribe_to_sql_notifications(subscriber)
    ActiveSupport::Notifications.unsubscribe(subscriber)
  end

  def self.time_statement(sql_statement)
    ActiveRecord::Base.connection.clear_query_cache

    Benchmark.realtime { ActiveRecord::Base.connection.send(:exec_query,
                                                            sql_statement.statement) }
  end

  def self.execute_query(query)
    ActiveRecord::Base.connection.execute(query)
  end

end
