class Swaggie::DurationFilter < Swaggie::AbstractFilter

  DURATION_MIN = 1.0
  DURATION_MAX = Float::INFINITY

  def filter
    new_dataset = @dataset.select do |sql_statement|
      (DURATION_MIN <= sql_statement.duration) and (sql_statement.duration <= DURATION_MAX)
    end

    new_dataset.sort do |sql_statement1, sql_statement2|
      sql_statement1.duration < sql_statement2.duration
    end
  end

end