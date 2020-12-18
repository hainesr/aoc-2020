# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/operation_order'

class AOC2020::OperationOrderTest < MiniTest::Test
  def setup
    @oo = AOC2020::OperationOrder.new
  end

  def test_eval_part
    assert_equal(1, @oo.eval_part(['1']).to_i)
    assert_equal(11, @oo.eval_part(['11']).to_i)
    assert_equal(11, @oo.eval_part(['5', '+', '6']).to_i)
    assert_equal(20, @oo.eval_part(['5', '+', '6', '+', '9']).to_i)
    assert_equal(21, @oo.eval_part(['1', '+', '5', '+', '6', '+', '9']).to_i)
    assert_equal(30, @oo.eval_part(['5', '*', '6']).to_i)
    assert_equal(30, @oo.eval_part(['5', '*', '1', '*', '6']).to_i)
    assert_equal(71, @oo.eval_part(%w[1 + 2 * 3 + 4 * 5 + 6]).to_i)
  end

  def test_eval_line
    assert_equal(1, @oo.eval_line('1'))
    assert_equal(11, @oo.eval_line('11'))
    assert_equal(11, @oo.eval_line('5 + 6'))
    assert_equal(20, @oo.eval_line('5 + 6 + 9'))
    assert_equal(21, @oo.eval_line('1 + 5 + 6 + 9'))
    assert_equal(30, @oo.eval_line('5 * 6'))
    assert_equal(30, @oo.eval_line('5 * 1 * 6'))
    assert_equal(71, @oo.eval_line('1 + 2 * 3 + 4 * 5 + 6'))
    assert_equal(11, @oo.eval_line('(5 + 6)'))
    assert_equal(20, @oo.eval_line('(5 + 6 + 9)'))
    assert_equal(20, @oo.eval_line('5 + (6 + 9)'))
    assert_equal(20, @oo.eval_line('(5 + 6) + 9'))
    assert_equal(30, @oo.eval_line('(5 * 6)'))
    assert_equal(51, @oo.eval_line('1 + (2 * 3) + (4 * (5 + 6))'))
    assert_equal(26, @oo.eval_line('2 * 3 + (4 * 5)'))
    assert_equal(437, @oo.eval_line('5 + (8 * 3 + 9 + 3 * 4 * 3)'))
    assert_equal(
      12_240, @oo.eval_line('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))')
    )
    assert_equal(
      13_632, @oo.eval_line('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2')
    )
  end
end
