# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/docking_data'

class AOC2020::DockingDataTest < MiniTest::Test
  INPUT = <<~EOINPUT
    mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
    mem[8] = 11
    mem[7] = 101
    mem[8] = 0
  EOINPUT

  def setup
    @dd = AOC2020::DockingData.new
  end

  # rubocop:disable Style/WordArray
  def test_parse_mask
    assert_equal(
      [:mask, 'X1XXXX0X', 0b11111101, 0b01000000],
      @dd.parse_mask(['mask', 'X1XXXX0X'])
    )
  end
  # rubocop:enable Style/WordArray

  def test_parse_mem
    assert_equal([:mem, 8, 11], @dd.parse_mem(['mem[8]', '11']))
    assert_equal([:mem, 7, 101], @dd.parse_mem(['mem[7]', '101']))
  end

  def test_load
    assert_equal(
      [
        [:mask, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X', 68_719_476_733, 64],
        [:mem, 8, 11],
        [:mem, 7, 101],
        [:mem, 8, 0]
      ],
      @dd.load(INPUT)
    )
  end

  def test_compute
    assert_equal(165, @dd.compute(@dd.load(INPUT)))
  end
end
