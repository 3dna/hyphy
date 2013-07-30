class Hyphy::Dataset

  attr_accessor :data

  def initialize(data=[])
    @data = data
  end

  def apply_filter(filter_class, opts={})
    filter = filter_class.new(@data, opts)
    filter.filter
  end

end
