# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/custom_customs'

class AOC2020::CustomCustomsTest < MiniTest::Test
  GROUPS = <<~EOGROUPS
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
  EOGROUPS

  def setup
    @cc = AOC2020::CustomCustoms.new
  end

  def test_parse
    groups = @cc.parse(GROUPS)
    assert_equal(%w[a b c], groups[0])
    assert_equal(%w[a b c], groups[1])
    assert_equal(%w[a b a c], groups[2])
  end

  def test_counts
    assert_equal([3, 3, 3, 1, 1], @cc.counts(@cc.parse(GROUPS)))
  end
end
