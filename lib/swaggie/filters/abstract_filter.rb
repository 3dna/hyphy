class Swaggie::AbstractFilter

  attr_reader :dataset

  def initialize(dataset, opts={})
    @dataset = dataset
  end

  def filter
    @dataset
  end

end
