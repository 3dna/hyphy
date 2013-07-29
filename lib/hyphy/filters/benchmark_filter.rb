class Hyphy::BenchmarkFilter < Hyphy::AbstractFilter

  def initialize(data, opts)
    @runs = opts[:runs] || 1

    super
  end

  def filter
    @data.each do |sql_statement|
      timing = self.class.benchmark(sql_statement, @runs)

      sql_statement.add_metadata('benchmark_runs',
                                 @runs)
      sql_statement.add_metadata('benchmark_time',
                                 timing)
    end
  end

  def self.benchmark(sql_statement, runs)
    times = []

    (1..runs).each do
      times << sql_statement.orm_adapter.time_statement(sql_statement)
    end

    # Calculate the average
    average = times.reduce(:+) / times.count
    average.to_f
  end

end
