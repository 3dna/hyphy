class Hyphy::Sampler

  attr_accessor :dataset
  attr_reader :orm_adapter, :metadata_callbacks

  class UnsupportedORMException < Exception; end

  def initialize(opts={})
    orm = opts[:orm] || :active_record

    if orm == :active_record
      @orm_adapter = Hyphy::ActiveRecordAdapter
    else
      raise UnsupportedORMException, 'ORM #{orm} is not supported'
    end

    @dataset = []
    @metadata_callbacks = {}
  end

  def log_sql(statement, start_time, end_time, orm_adapter)
    sql_statement = Hyphy::SQLStatement.new(:statement => statement,
                                            :start_time => start_time,
                                            :end_time => end_time,
                                            :orm_adapter => orm_adapter,
                                            :trace => caller)
    @dataset << sql_statement
    sql_statement
  end

  def process_metadata(sql_statement)
    @metadata_callbacks.each do |key, value_block|
      sql_statement.metadata[key] = value_block.call
    end
  end

  def sample(statement, start_time, end_time)
    sql_statement = log_sql(statement, start_time, end_time, @orm_adapter)
    process_metadata(sql_statement)
    sql_statement
  end

  def add_metadata(name, &block)
    @metadata_callbacks[name] = block
  end

  def begin
    @subscriber = @orm_adapter.subscribe_to_sql_notifications(method(:sample))
  end

  def stop
    @orm_adapter.unsubscribe_to_sql_notifications(@subscriber)
  end

  def profile
    self.begin
    yield
    self.stop
  end

  def apply_filter(filter_class, opts={})
    filter = filter_class.new(@dataset, opts)
    filter.filter
  end

end
