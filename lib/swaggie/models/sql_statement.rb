Swaggie::DB.create_table(:sql_statements) do
  primary_key :id

  String :statement, :text=>true
  Float :start_time
  Float :end_time
end

class Swaggie::SQLStatement < Sequel::Model

  def duration
    end_time - start_time
  end

end
