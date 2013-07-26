class Hyphy::AbstractORMAdapter

  def self.subscribe_to_sql_notifications(callback); end

  def self.unsubscribe_to_sql_notifications(subscriber); end

  def self.time_statement(statement); end

end
