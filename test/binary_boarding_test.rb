# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/binary_boarding'

class AOC2020::BinaryBoardingTest < MiniTest::Test
  SEATS = [
    ['FBFBBFFRLR', 44, 5, 357],
    ['BFFFBBFRRR', 70, 7, 567],
    ['FFFBBBFRRR', 14, 7, 119],
    ['BBFFBBFRLL', 102, 4, 820]
  ].freeze

  def setup
    @bb = AOC2020::BinaryBoarding.new
  end

  def test_seat_number
    SEATS.each do |code, row, column, id|
      r, c, i = @bb.seat_number(code)
      assert_equal(row, r)
      assert_equal(column, c)
      assert_equal(id, i)
    end
  end
end
