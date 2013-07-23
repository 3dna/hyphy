class Swaggie::Sampler

  attr_reader :orm_adapter

  class UnsupportedORMException < Exception; end

  def initialize(opts={})
    orm = opts[:orm] || :active_record

    if orm == :active_record
      @orm_adapter = Swaggie::ActiveRecordAdapter
    else
      raise UnsupportedORMException, 'ORM #{orm} is not supported'
    end
  end

  def begin
    @orm_adapter.subscribe_to_sql_notifications
  end

end
