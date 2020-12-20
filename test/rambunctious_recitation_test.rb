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

  def test_take_turn
    game = AOC2020::RambunctiousRecitation::Game.new([0, 3, 6])
    assert_equal([1, 0], game.take_turn)
    assert_equal([2, 3], game.take_turn)
    assert_equal([3, 6], game.take_turn)
    assert_equal([4, 0], game.take_turn)
    assert_equal([5, 3], game.take_turn)
    assert_equal([6, 3], game.take_turn)
    assert_equal([7, 1], game.take_turn)
    assert_equal([8, 0], game.take_turn)
    assert_equal([9, 4], game.take_turn)
    assert_equal([10, 0], game.take_turn)
  end

  def test_play_to
    [
      [[0, 3, 6], 436],
      [[1, 3, 2], 1],
      [[2, 1, 3], 10],
      [[1, 2, 3], 27],
      [[2, 3, 1], 78],
      [[3, 2, 1], 438],
      [[3, 1, 2], 1836]
    ].each do |start, number|
      game = AOC2020::RambunctiousRecitation::Game.new(start)
      assert_equal(number, game.play_to(2020))
    end
  end
end
