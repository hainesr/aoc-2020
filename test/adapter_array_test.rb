# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/adapter_array'

class AOC2020::AdapterArrayTest < MiniTest::Test
  INPUT1 = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4].join("\n")
  INPUT2 = [
    28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19,
    38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3
  ].join("\n")

  def setup
    @aa = AOC2020::AdapterArray.new
  end

  def test_jolt_steps
    assert_equal(
      { 1 => 7, 3 => 5 }, @aa.jolt_steps(@aa.read_adapters(INPUT1))
    )
    assert_equal(
      { 1 => 22, 3 => 10 }, @aa.jolt_steps(@aa.read_adapters(INPUT2))
    )
  end

  def test_count_all_chains
    assert_equal(8, @aa.count_all_chains(@aa.read_adapters(INPUT1)))
    assert_equal(19_208, @aa.count_all_chains(@aa.read_adapters(INPUT2)))
  end
end
