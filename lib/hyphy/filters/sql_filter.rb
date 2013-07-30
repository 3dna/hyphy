class Hyphy::Filters::SQLFilter < Hyphy::Filters::AbstractFilter

  class IncorrectSQLTypeException < Exception; end

  def initialize(data, opts={})
    @type = opts[:type] || :select

    unless [:select, :insert].include?(@type)
      raise IncorrectSQLTypeException, "incorrect type: #{@type}"
    end

    super
  end

  def filter
    @data.select! do |sql_statement|
      sql_statement.send("#{@type}?".to_sym)
    end
  end

end
