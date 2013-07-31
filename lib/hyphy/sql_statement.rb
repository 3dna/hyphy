class Hyphy::SQLStatement

  DIGIT_MARKER = '<digit>'

  attr_accessor(:statement,
                :trace,
                :metadata,
                :binds,
                :plan,
                :orm_adapter,
                :start_time,
                :end_time,
                :benchmark_runs,
                :benchmark_time)

  def initialize(opts={})
    @statement = opts[:statement]
    @start_time = opts[:start_time]
    @end_time = opts[:end_time]
    @orm_adapter = opts[:orm_adapter]
    @trace = opts[:trace] || []
    @binds = opts[:binds] || []
    @metadata = opts[:metadata] || {}
  end

  def duration
    @duration ||= (end_time - start_time)
  end

  def stripped_statement
    @stripped_statement ||= statement.strip
  end

  def select?
    @select ||= stripped_statement.upcase.match(/^SELECT/)
  end

  def insert?
    @insert ||= stripped_statement.upcase.match(/^INSERT/)
  end

  def digitless
    @digitless ||= stripped_statement.gsub(/\d+/, DIGIT_MARKER)
  end

  def application_trace
    return @application_trace if @application_trace

    regex = Regexp.new("^#{Dir.pwd}")
    @application_trace ||= trace.select { |line| regex.match(line) }
  end

end
