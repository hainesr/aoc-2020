# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/crab_cups'

class AOC2020::CrabCupsTest < MiniTest::Test
  LABELS = [3, 8, 9, 1, 2, 5, 4, 6, 7].freeze

  def setup
    @cc = AOC2020::CrabCups.new
  end

  def test_play
    assert_equal([5, 4, 6, 7, 3, 2, 8, 9], @cc.play(LABELS, 1))
    assert_equal([3, 2, 5, 4, 6, 7, 8, 9], @cc.play(LABELS, 2))
    assert_equal([3, 4, 6, 7, 2, 5, 8, 9], @cc.play(LABELS, 3))
    assert_equal([6, 7, 3, 8, 4, 5, 2, 9], @cc.play(LABELS))
  end
end
