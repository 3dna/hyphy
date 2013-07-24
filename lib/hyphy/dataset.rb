class Hyphy::Dataset

  attr_reader :data

  def initialize(data=nil)
    @data = data || Hyphy::SQLStatement.all
  end

  def apply_filter(filter_class, opts={})
    filter = filter_class.new(@data, opts)
    @data = filter.filter
  end

end
