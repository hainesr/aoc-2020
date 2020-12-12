# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/rain_risk'

class AOC2020::RainRiskTest < MiniTest::Test
  INSTRUCTIONS = <<~EOINST
    F10
    N3
    F7
    R90
    F11
  EOINST

  def setup
    @rr = AOC2020::RainRisk.new
  end

  def test_move
    assert_equal([17, -8], @rr.move(INSTRUCTIONS.split))
  end

  def test_move_waypoint
    assert_equal([214, -72], @rr.move_waypoint(INSTRUCTIONS.split))
  end

  def test_manhattan
    assert_equal(25, @rr.manhattan([17, -8]))
    assert_equal(286, @rr.manhattan([214, -72]))
  end
end
