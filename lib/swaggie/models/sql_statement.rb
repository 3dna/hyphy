Swaggie::DB.create_table(:sql_statements) do
  primary_key :id

  String :statement, :text => true
  Float :start_time
  Float :end_time
end

class Swaggie::SQLStatement < Sequel::Model

  DIGIT_MARKER = '<digit>'

  def duration
    end_time - start_time
  end

  def stripped_statement
    statement.strip
  end

  def digitless
    without_digits = stripped_statement.gsub(/\d+/, DIGIT_MARKER)
  end

end
