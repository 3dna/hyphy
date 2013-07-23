class Swaggie::AbstractORMAdapter

  def self.log_sql(statement, start_time, end_time)
    sql_statement = Swaggie::SQLStatement.new(:statement => statement,
                                              :start_time => start_time,
                                              :end_time => end_time)
    sql_statement.save
  end

end
