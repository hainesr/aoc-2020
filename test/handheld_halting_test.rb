# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/handheld_halting'

class AOC2020::HandheldHaltingTest < MiniTest::Test
  PROGRAM = <<~EOPROG
    nop +0
    acc +1
    jmp +4
    acc +3
    jmp -3
    acc -99
    acc +1
    jmp -4
    acc +6
  EOPROG

  def setup
    @hh = AOC2020::HandheldHalting.new
  end

  def test_load
    assert_equal(
      [
        [:nop, 0],
        [:acc, 1],
        [:jmp, 4],
        [:acc, 3],
        [:jmp, -3],
        [:acc, -99],
        [:acc, 1],
        [:jmp, -4],
        [:acc, 6]
      ],
      @hh.load(PROGRAM)
    )
  end

  def test_execute
    program = @hh.load(PROGRAM)
    assert_equal(5, @hh.execute(program))
  end
end
