# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/password_philosophy'

class AOC2020::PasswordPhilosophyTest < MiniTest::Test
  PASSWORD_LIST = [
    '1-3 a: abcde',
    '1-3 b: cdefg',
    '2-9 c: ccccccccc'
  ].freeze

  PASSWORD_PARSED = [
    ['a', 1, 3, 'abcde'],
    ['b', 1, 3, 'cdefg'],
    ['c', 2, 9, 'ccccccccc']
  ].freeze

  def setup
    @pp = AOC2020::PasswordPhilosophy.new
  end

  def test_parse
    assert_equal(PASSWORD_PARSED, @pp.parse(PASSWORD_LIST))
  end

  def test_valid1?
    list = @pp.parse(PASSWORD_LIST)
    assert(@pp.valid1?(list[0]))
    refute(@pp.valid1?(list[1]))
    assert(@pp.valid1?(list[2]))
  end

  def test_valid2?
    list = @pp.parse(PASSWORD_LIST)
    assert(@pp.valid2?(list[0]))
    refute(@pp.valid2?(list[1]))
    refute(@pp.valid2?(list[2]))
  end
end
