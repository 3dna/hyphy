class Hyphy::DurationFilter < Hyphy::AbstractFilter

  attr_reader :duration_min, :duration_max

  def initialize(data, opts)
    @duration_min = opts[:duration_min] || 0.0
    @duration_max = opts[:duration_max] || Float::INFINITY
    @benchmark = opts[:benchmark] || false

    if @benchmark
      @duration = lambda { |sql_statement| sql_statement.metadata['benchmark_time'] }
    else
      @duration = lambda { |sql_statement| sql_statement.duration }
    end

    super
  end

  def filter
    @data.select! do |sql_statement|
      next unless @duration.call(sql_statement)

      (@duration_min <= @duration.call(sql_statement)) and (@duration.call(sql_statement) <= @duration_max)
    end

    @data.sort_by! { |sql_statement| -sql_statement.duration }
  end

end
