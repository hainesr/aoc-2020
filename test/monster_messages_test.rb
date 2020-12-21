# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/monster_messages'

class AOC2020::MonsterMessagesTest < MiniTest::Test
  INPUT = <<~EOINPUT
    0: 4 1 5
    1: 2 3 | 3 2
    2: 4 4 | 5 5
    3: 4 5 | 5 4
    4: "a"
    5: "b"

    ababbb
    bababa
    abbbab
    aaabbb
    aaaabbb
  EOINPUT

  def setup
    @mm = AOC2020::MonsterMessages.new
  end

  def test_parse
    rules, messages = @mm.parse(INPUT)
    assert_equal(%w[ababbb bababa abbbab aaabbb aaaabbb], messages)
    assert_equal([4, 1, 5], rules[0])
    assert_equal('a', rules[4])
    assert_equal([[2, 3], [3, 2]], rules[1])
  end

  def test_expand_rule
    rules, = @mm.parse(INPUT)
    assert_equal('a', @mm.expand_rule(4, rules))
    assert_equal('b', @mm.expand_rule(5, rules))
    assert_equal('(?:ab|ba)', @mm.expand_rule(3, rules))
    assert_equal('(?:aa|bb)', @mm.expand_rule(2, rules))
    assert_equal(
      '(?:(?:aa|bb)(?:ab|ba)|(?:ab|ba)(?:aa|bb))', @mm.expand_rule(1, rules)
    )
    assert_equal(
      '(?:a(?:(?:aa|bb)(?:ab|ba)|(?:ab|ba)(?:aa|bb))b)',
      @mm.expand_rule(0, rules)
    )
  end

  def test_match_rule?
    rules, messages = @mm.parse(INPUT)
    rule = @mm.expand_rule(0, rules)
    assert(@mm.match_rule?(messages[0], rule))
    refute(@mm.match_rule?(messages[1], rule))
    assert(@mm.match_rule?(messages[2], rule))
    refute(@mm.match_rule?(messages[3], rule))
    refute(@mm.match_rule?(messages[4], rule))
  end
end
