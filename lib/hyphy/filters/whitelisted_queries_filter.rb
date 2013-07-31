class Hyphy::Filters::WhitelistedQueriesFilter < Hyphy::Filters::AbstractFilter

  def initialize(data, opts={})
    @query_whitelist = opts[:query_whitelist] || []

    super
  end

  def filter
    @data.select! { |sql_statement| not @query_whitelist.include?(sql_statement.digitless) }
  end

end
