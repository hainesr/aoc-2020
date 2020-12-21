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

  INPUT2 = <<~EOINPUT2
    42: 9 14 | 10 1
    9: 14 27 | 1 26
    10: 23 14 | 28 1
    1: "a"
    11: 42 31
    5: 1 14 | 15 1
    19: 14 1 | 14 14
    12: 24 14 | 19 1
    16: 15 1 | 14 14
    31: 14 17 | 1 13
    6: 14 14 | 1 14
    2: 1 24 | 14 4
    0: 8 11
    13: 14 3 | 1 12
    15: 1 | 14
    17: 14 2 | 1 7
    23: 25 1 | 22 14
    28: 16 1
    4: 1 1
    20: 14 14 | 1 15
    3: 5 14 | 16 1
    27: 1 6 | 14 18
    14: "b"
    21: 14 1 | 1 14
    25: 1 1 | 1 14
    22: 14 14
    8: 42
    26: 14 22 | 1 20
    18: 15 15
    7: 14 5 | 1 21
    24: 14 1

    abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
    bbabbbbaabaabba
    babbbbaabbbbbabbbbbbaabaaabaaa
    aaabbbbbbaaaabaababaabababbabaaabbababababaaa
    bbbbbbbaaaabbbbaaabbabaaa
    bbbababbbbaaaaaaaabbababaaababaabab
    ababaaaaaabaaab
    ababaaaaabbbaba
    baabbaaaabbaaaababbaababb
    abbbbabbbbaaaababbbbbbaaaababb
    aaaaabbaabaaaaababaa
    aaaabbaaaabbaaa
    aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
    babaaabbbaaabaababbaabababaaab
    aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba
  EOINPUT2

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

  def test_match_rule2?
    rules, messages = @mm.parse(INPUT2)

    # Before editing the rules we should match 3.
    rule = @mm.expand_rule(0, rules)
    num = messages.map { |m| @mm.match_rule?(m, rule) }.count(true)
    assert_equal(3, num)

    # After editing the rules we should match 12.
    @mm.seed_cache(rules)
    rule = @mm.expand_rule(0, rules)
    num = messages.map { |m| @mm.match_rule?(m, rule) }.count(true)
    assert_equal(12, num)
  end
end
