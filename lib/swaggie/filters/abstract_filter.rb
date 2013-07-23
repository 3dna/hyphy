class Swaggie::AbstractFilter

  attr_reader :dataset

  def initialize(dataset)
    @dataset = dataset
  end

  def filter
    @dataset
  end

end
