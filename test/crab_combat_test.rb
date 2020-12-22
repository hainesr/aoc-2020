# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/crab_combat'

class AOC2020::CrabCombatTest < MiniTest::Test
  DECKS = <<~EODECKS
    Player 1:
    9
    2
    6
    3
    1

    Player 2:
    5
    8
    4
    7
    10
  EODECKS

  def setup
    @cc = AOC2020::CrabCombat.new
  end

  def test_read_decks
    assert_equal([[9, 2, 6, 3, 1], [5, 8, 4, 7, 10]], @cc.read_decks(DECKS))
  end

  def test_play
    decks = @cc.read_decks(DECKS)

    decks = @cc.play(decks, finish: false)
    assert_equal([[2, 6, 3, 1, 9, 5], [8, 4, 7, 10]], decks)

    decks = @cc.play(decks, finish: false)
    assert_equal([[6, 3, 1, 9, 5], [4, 7, 10, 8, 2]], decks)

    decks = @cc.play(decks, finish: false)
    assert_equal([[3, 1, 9, 5, 6, 4], [7, 10, 8, 2]], decks)

    deck = @cc.play(decks)
    assert_equal([3, 2, 10, 6, 8, 5, 9, 4, 7, 1], deck)
  end

  def test_score
    assert_equal(306, @cc.score([3, 2, 10, 6, 8, 5, 9, 4, 7, 1]))
  end
end
