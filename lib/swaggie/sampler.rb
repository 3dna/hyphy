module Swaggie::Sampler

  class UnsupportedORMException < Exception; end

  def self.begin(opts={})
    orm = opts[:orm] || :active_record

    if orm == :active_record
      orm_adapter = Swaggie::ActiveRecordAdapter
    else
      raise UnsupportedORMException, 'ORM #{orm} is not supported'
    end

    orm_adapter.subscribe_to_sql_notifications
  end

end
