class Hyphy::LimitFilter < Hyphy::AbstractFilter

  def initialize(dataset, opts)
    @limit = opts[:limit] || 10

    super
  end

  def filter
    @dataset.data = @dataset.data[(0...@limit)]
  end

end
