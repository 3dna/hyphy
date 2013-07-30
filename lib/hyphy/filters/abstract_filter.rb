class Hyphy::Filters::AbstractFilter

  attr_reader :data

  def initialize(data, opts={})
    @data = data
  end

  def filter
    @data
  end

end
