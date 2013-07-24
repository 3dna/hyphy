class Hyphy::DurationFilter < Hyphy::AbstractFilter

  attr_reader :duration_min, :duration_max

  def initialize(dataset, opts)
    @duration_min = opts[:duration_min] || 0.0
    @duration_max = opts[:duration_max] || Float::INFINITY

    super
  end

  def filter
    new_dataset = @dataset.select do |sql_statement|
      (@duration_min <= sql_statement.duration) and (sql_statement.duration <= @duration_max)
    end

    new_dataset.sort_by { |sql_statement| -sql_statement.duration }
  end

end
