class Swaggie::DurationFilter < Swaggie::AbstractFilter

  DURATION_MIN = 1.0
  DURATION_MAX = Float::INFINITY

  def filter
    @dataset.select do |sql_statement|
      (DURATION_MIN <= sql_statement.duration) and (sql_statement.duration <= DURATION_MAX)
    end
  end

end
