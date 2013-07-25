require 'oj'

class Hyphy::Sampler

  attr_reader :orm_adapter, :metadata_callbacks

  class UnsupportedORMException < Exception; end

  def initialize(opts={})
    orm = opts[:orm] || :active_record

    if orm == :active_record
      @orm_adapter = Hyphy::ActiveRecordAdapter
    else
      raise UnsupportedORMException, 'ORM #{orm} is not supported'
    end

    @metadata_callbacks = {}
  end

  def log_sql(statement, start_time, end_time)
    Hyphy::SQLStatement.create(:statement => statement,
                               :start_time => start_time,
                               :end_time => end_time,
                               :trace_json => Oj.dump(caller))
  end

  def process_metadata(sql_statement)
    @metadata_callbacks.each do |key, value_block|
      sql_statement.add_metadata(key, value_block.call)
    end
  end

  def sample(statement, start_time, end_time)
    sql_statement = log_sql(statement, start_time, end_time)
    process_metadata(sql_statement)
  end

  def add_metadata(name, &block)
    @metadata_callbacks[name] = block
  end

  def begin
    @orm_adapter.subscribe_to_sql_notifications(method(:sample))
  end

end
