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
end
