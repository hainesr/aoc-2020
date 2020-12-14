# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/docking_data'

class AOC2020::DockingDataTest < MiniTest::Test
  INPUT1 = <<~EOINPUT1
    mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
    mem[8] = 11
    mem[7] = 101
    mem[8] = 0
  EOINPUT1

  INPUT2 = <<~EOINPUT2
    mask = 000000000000000000000000000000X1001X
    mem[42] = 100
    mask = 00000000000000000000000000000000X0XX
    mem[26] = 1
  EOINPUT2

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
      @dd.load(INPUT1)
    )
  end

  def test_compute1
    assert_equal(165, @dd.compute1(@dd.load(INPUT1)))
  end

  def test_expand_mask
    assert_equal(['01'], @dd.expand_mask('01'))
    assert_equal(['0', '1'], @dd.expand_mask('X'))
    assert_equal(['10', '11'], @dd.expand_mask('1X'))
    assert_equal(['101', '111'], @dd.expand_mask('1X1'))
    assert_equal(['10001', '10011', '11001', '11011'], @dd.expand_mask('1X0X1'))
    assert_equal(
      ['000', '001', '010', '011', '100', '101', '110', '111'],
      @dd.expand_mask('XXX')
    )
  end
  # rubocop:enable Style/WordArray

  def test_mask_address
    assert_equal(
      [26, 27, 58, 59],
      @dd.mask_address('000000000000000000000000000000X1001X', 42)
    )
  end

  def test_compute2
    assert_equal(208, @dd.compute2(@dd.load(INPUT2)))
  end
end
