# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/encoding_error'

class AOC2020::EncodingErrorTest < MiniTest::Test
  INPUT = [
    35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102,
    117, 150, 182, 127, 219, 299, 277, 309, 576
  ].freeze

  def setup
    @ee = AOC2020::EncodingError.new
  end

  def test_find_error
    assert_equal(127, @ee.find_error(INPUT, 5))
  end
end
