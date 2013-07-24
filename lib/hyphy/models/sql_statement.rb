require 'json'

Hyphy::DB.create_table(:sql_statements) do
  primary_key :id

  String :statement, :text => true
  String :trace_json, :text => true
  String :metadata_json, :text => true
  Float :start_time
  Float :end_time
end

class Hyphy::SQLStatement < Sequel::Model

  DIGIT_MARKER = '<digit>'

  def duration
    @duration ||= (end_time - start_time)
  end

  def stripped_statement
    statement.strip
  end

  def digitless
    without_digits = stripped_statement.gsub(/\d+/, DIGIT_MARKER)
  end

  def trace
    JSON.parse(trace_json)
  end

  def metadata
    return {} unless metadata_json
    JSON.parse(metadata_json)
  end

  def add_metadata(key, value)
    new_metadata = metadata
    new_metadata[key] = value
    self.metadata_json = JSON(new_metadata)
    save
  end

  def self.truncate_table
    Hyphy::DB[:sql_statements].truncate
  end

end
