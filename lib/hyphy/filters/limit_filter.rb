class Hyphy::LimitFilter < Hyphy::AbstractFilter

  def initialize(data, opts)
    @limit = opts[:limit] || 10

    super
  end

  def filter
    @data = @data[(0...@limit)]
  end

end
