require 'json'

class Hyphy::Filters::ExplainFilter < Hyphy::Filters::AbstractFilter

  def initialize(data, opts)
    @prep_queries = opts[:prep_queries] || []
    @connection = opts[:connection] || Hyphy::ActiveRecordAdapter

    super
  end

  def filter
    @data.each do |sql_statement|
      @prep_queries.each { |query| @connection.exec(query) }

      explain_query = "explain (format json, analyze) #{sql_statement.statement}"
      plan = @connection.exec(explain_query).values[0][0]
      sql_statement.plan = JSON.parse(plan)
    end
  end

end
