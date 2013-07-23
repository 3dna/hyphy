class Swaggie::DatasetCollection

  class InvalidKeyException < Exception; end

  attr_reader :dataset_collection

  def initialize(dataset, key)
    raise InvalidKeyException unless Swaggie::SQLStatement.method_defined?(key)

    @key = key
    @dataset = dataset
    @dataset_collection = {}
  end

  def process_dataset
    collection = Hash.new { |hash, key| hash[key] = [] }

    @dataset.data.each do |sql_statement|
      collection[sql_statement.send(@key)] = sql_statement
    end

    collection.each { |key, value| @dataset_collection[key] = Swaggie::Dataset.new(value) }
  end

end
