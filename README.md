# Hyphy

Hyphy is a toolkit for identifying SQL bottlenecks in Ruby applications. Given
an adapter for an ORM and a Ruby block, Hyphy collects all executed queries in
a dataset. Afterward, it can filter the dataset and even benchmark the queries.
At [NationBuilder](http://nationbuilder.com/), we use this gem to conduct
performance regression tests.

## Supported ORMs

Hyphy only comes with out of the box support for ActiveRecord. Adding a new ORM
should be easy, however.

## Creating datasets

You can create a new dataset by initializing a `Sampler` object.
```ruby
require 'hyphy'
sampler = Hyphy::Sampler.new(:orm => :active_record)
```

## Sampling queries

Once we've created our `Sampler` object, it is very easy to start collecting data.
Simply enclose the application code that you need profiled in a block and pass it
to the `profile` method. Example:

```ruby
sampler.profile do
  # Application code goes here
end
```

## Filtering queries

Hyphy comes with a few filters that fit common use cases. Here is how they can
be used:

```ruby
# Only keep SQL 'select' queries
sampler.apply_filter(Hyphy::Filters::SQLFilter, :type => :select)

# Only keep queries that had a running time r such that .01 < r < .05
sampler.apply_filter(Hyphy::Filters::DurationFilter,
                     :duration_min => 0.01,
                     :duration_max => 0.05)

# Keep the top 10 results
sampler.apply_filter(Hyphy::Filters::LimitFilter,
                     :limit => 10)

# Benchmark each query with 10 runs (this saves the benchmark information)
sampler.apply_filter(Hyphy::Filters::BenchmarkFilter, :runs => 10)

# Using the benchmark information, keep queries that fit the
# duration requirements.
sampler.apply_filter(Hyphy::Filters::DurationFilter,
                     :benchmark => true,
                     :duration_min => 0.01,
                     :duration_max => 0.05))
```

## Accessing data

To form reports using the data that remains after filtering, we
use the `SQLStatement` objects in `sampler.dataset`.

```ruby
sql_statement = sampler.dataset.first

sql_statement.statement
"Select * from users"

sql_statement.duration
0.03

sql_statement.application_trace
["/src/application/app/models/model.rb:24:in `make_query'"]

sql_statement.benchmark_runs
10

sql_statement.benchmark_time
0.0324
```

## Contributing to Hyphy

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Hyphy has *100% test coverage*; keep it that way.

## Copyright

Copyright (c) 2013 David Huie. See LICENSE.txt for
further details.
