# TimeSeq

A well-understood interface to build lazy enumerator for iterating time points

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'time_seq'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install time_seq

## Usage

```ruby
require 'time_seq'

seq = TimeSeq.new from: Time.gm(2016, 'nov'), step: 1.hour, to: Time.gm(2016, 'nov', 1, 5)
=> #<TimeSeq:19952030 @from=2016-11-01 00:00:00 UTC, @step=1 hour, @to=2016-11-01 05:00:00 UTC>
seq.to_a
=> [2016-11-01 00:00:00 UTC,
    2016-11-01 01:00:00 UTC,
    2016-11-01 02:00:00 UTC,
    2016-11-01 03:00:00 UTC,
    2016-11-01 04:00:00 UTC,
    2016-11-01 05:00:00 UTC]

# Ending is not required. It can do whatever a Enumerator::Lazy can do
infinite_seq = TimeSeq.new from: Time.gm(2016, 'dec', 1, 7, 30), step: 1.day
=> #<TimeSeq:19403900 @from=2016-12-01 07:30:00 UTC, @step=1 day>
infinite_seq.first(10)
=> [2016-12-01 07:30:00 UTC,
    2016-12-02 07:30:00 UTC,
    2016-12-03 07:30:00 UTC,
    2016-12-04 07:30:00 UTC,
    2016-12-05 07:30:00 UTC,
    2016-12-06 07:30:00 UTC,
    2016-12-07 07:30:00 UTC,
    2016-12-08 07:30:00 UTC,
    2016-12-09 07:30:00 UTC,
    2016-12-10 07:30:00 UTC]
```
