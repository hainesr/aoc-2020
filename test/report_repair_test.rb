# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/report_repair'

class AOC2020::ReportRepairTest < MiniTest::Test
  LIST = [1_721, 979, 366, 299, 675, 1_456].freeze

  def setup
    @rr = AOC2020::ReportRepair.new
  end

  def test_sum2
    assert_equal(514_579, @rr.sum2(LIST))
  end

  def test_sum3
    assert_equal([979, 366, 675], @rr.sum3(LIST))
  end
end
