require 'json'

class Hyphy::AbstractORMAdapter

  def self.log_sql(statement, start_time, end_time)
    Hyphy::SQLStatement.create(:statement => statement,
                               :start_time => start_time,
                               :end_time => end_time,
                               :trace_json => JSON(caller))
  end

end
