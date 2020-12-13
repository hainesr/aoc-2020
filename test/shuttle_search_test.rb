# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/shuttle_search'

class AOC2020::ShuttleSearchTest < MiniTest::Test
  INPUT = <<~EOINPUT.split
    939
    7,13,x,x,59,x,31,19
  EOINPUT

  def setup
    @ss = AOC2020::ShuttleSearch.new
  end

  def test_earliest_time
    assert_equal(939, @ss.earliest_time(INPUT))
  end

  def test_running_services
    assert_equal([7, 13, 59, 31, 19], @ss.running_services(INPUT))
  end

  def test_next_bus
    assert_equal([59, 5], @ss.next_bus(INPUT))
  end

  def test_buses_with_offset
    assert_equal(
      [[7, 0], [13, 1], [59, 4], [31, 6], [19, 7]],
      @ss.buses_with_offset(INPUT)
    )
  end

  def test_contest
    assert_equal(1_068_781, @ss.contest(INPUT))
    assert_equal(3_417, @ss.contest([nil, '17,x,13,19']))
    assert_equal(1_202_161_486, @ss.contest([nil, '1789,37,47,1889']))
  end
end
