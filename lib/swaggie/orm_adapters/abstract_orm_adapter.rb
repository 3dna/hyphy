require 'json'

class Swaggie::AbstractORMAdapter

  def self.log_sql(statement, start_time, end_time)
    Swaggie::SQLStatement.create(:statement => statement,
                                 :start_time => start_time,
                                 :end_time => end_time,
                                 :trace_json => JSON(caller))
  end

end
