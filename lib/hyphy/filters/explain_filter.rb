require 'json'

class Hyphy::Filters::ExplainFilter < Hyphy::Filters::AbstractFilter

  def initialize(data, opts)
    @prep_queries = opts[:prep_queries] || []

    super
  end

  def filter
    @data.each do |sql_statement|
      @prep_queries.each { |query| sql_statement.orm_adapter.execute_query(query) }

      explain_query = "explain (format json, analyze) #{sql_statement.statement}"
      plan = sql_statement.orm_adapter.execute_query(explain_query).values[0][0]
      sql_statement.plan = JSON.parse(plan)
    end
  end

end
