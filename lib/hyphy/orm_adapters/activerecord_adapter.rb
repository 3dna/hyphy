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

      sql_statement = callback.call(sql, start_time, end_time)
      sql_statement.binds = binds
      sql_statement.save
    end
  end

  def self.unsubscribe_to_sql_notifications(subscriber)
    ActiveSupport::Notifications.unsubscribe(subscriber)
  end

  def self.time_statement(sql_statement)
    ActiveRecord::Base.connection.clear_query_cache

    binds = sql_statement.binds
    Benchmark.realtime { ActiveRecord::Base.connection.send(:exec_query,
                                                            sql_statement.statement,
                                                            'SQL',
                                                            binds) }
  end

end
