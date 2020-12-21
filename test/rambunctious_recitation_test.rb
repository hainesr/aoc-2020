# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/rambunctious_recitation'

class AOC2020::RambunctiousRecitationTest < MiniTest::Test
  def setup
    @rr = AOC2020::RambunctiousRecitation.new
  end

  def test_play_to
    start = [0, 3, 6]
    assert_equal(0, @rr.play_to(1, start))
    assert_equal(3, @rr.play_to(2, start))
    assert_equal(6, @rr.play_to(3, start))
    assert_equal(0, @rr.play_to(4, start))
    assert_equal(3, @rr.play_to(5, start))
    assert_equal(3, @rr.play_to(6, start))
    assert_equal(1, @rr.play_to(7, start))
    assert_equal(0, @rr.play_to(8, start))
    assert_equal(4, @rr.play_to(9, start))
    assert_equal(0, @rr.play_to(10, start))

    [
      [[0, 3, 6], 436],
      [[1, 3, 2], 1],
      [[2, 1, 3], 10],
      [[1, 2, 3], 27],
      [[2, 3, 1], 78],
      [[3, 2, 1], 438],
      [[3, 1, 2], 1836]
    ].each do |init, number|
      assert_equal(number, @rr.play_to(2020, init))
    end
  end
end
