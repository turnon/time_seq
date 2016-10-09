require 'test_helper'

class TimeSeqTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TimeSeq::VERSION
  end

  def test_it_respond_to_enum_methods
    ts = TimeSeq.new
    Enumerator::Lazy.instance_methods.each do |method|
      assert_respond_to ts, method
    end
  end

  def test_head
    ts = TimeSeq.new from: start, step: 1.second
    assert_equal start, ts.next
  end

  def test_seconds_later
    ts = TimeSeq.new from: start, step: 1.second
    exp = fixed_time_seq [
            start,
            [2016, 'oct', 8, 21, 0, 1],
            [2016, 'oct', 8, 21, 0, 2]
    ]
    assert_equal exp, ts.first(3)
  end

  def test_minutes_later
    ts = TimeSeq.new from: start, step: 1.minute
    exp = fixed_time_seq [
            [2016, 'oct', 8, 21, 1],
            [2016, 'oct', 8, 21, 2],
            [2016, 'oct', 8, 21, 3]
    ]
    assert_equal exp, ts.drop(1).take(3).to_a
  end

  def test_hours_later
    ts = TimeSeq.new from: start, step: 6.hour
    exp = fixed_time_seq [
            [2016, 'oct', 8, 21],
            [2016, 'oct', 9, 3],
            [2016, 'oct', 9, 9]
    ]
    assert_equal exp, ts.first(3)
  end

  def test_hours_and_minutes_later
    ts = TimeSeq.new from: start, step: 1.hour + 60.minute
    exp = fixed_time_seq [
            start,
            [2016, 'oct', 8, 23],
            [2016, 'oct', 9, 1]
    ]
    assert_equal exp, ts.first(3)
  end

  def test_days_later
    ts = TimeSeq.new from: start, step: 0.5.day
    exp = fixed_time_seq [
            start,
            [2016, 'oct', 9, 9],
            [2016, 'oct', 9, 21]
    ]
    assert_equal exp, ts.first(3)
  end

  def test_years_and_months_later
    ts = TimeSeq.new from: start, step: 1.year + 6.month
    exp = fixed_time_seq [
            start,
            [2018, 'apr', 8, 21],
            [2019, 'oct', 8, 21]
    ]
    assert_equal exp, ts.first(3)
  end

  def test_bound
    ts = TimeSeq.new from: Time.now, step: 1.hour, to: 0.25.day.from_now
    assert_equal 7, ts.to_a.size
  end

  private

  def start
    Time.gm 2016, 'oct', 8, 21
  end

  def fixed_time_seq time_arr
    time_arr.map do |time_arg|
      Time.gm *time_arg
    end
  end

end
