# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/handy_haversacks'

class AOC2020::HandyHaversacksTest < MiniTest::Test
  BAGS = <<~EOBAGS
    light red bags contain 1 bright white bag, 2 muted yellow bags.
    dark orange bags contain 3 bright white bags, 4 muted yellow bags.
    bright white bags contain 1 shiny gold bag.
    muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
    shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
    dark olive bags contain 3 faded blue bags, 4 dotted black bags.
    vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
    faded blue bags contain no other bags.
    dotted black bags contain no other bags.
  EOBAGS

  BAGS2 = <<~EOBAGS2
    shiny gold bags contain 2 dark red bags.
    dark red bags contain 2 dark orange bags.
    dark orange bags contain 2 dark yellow bags.
    dark yellow bags contain 2 dark green bags.
    dark green bags contain 2 dark blue bags.
    dark blue bags contain 2 dark violet bags.
    dark violet bags contain no other bags.
  EOBAGS2

  def setup
    @hh = AOC2020::HandyHaversacks.new
  end

  def test_parse_bag
    assert_equal(:light_red, @hh.parse_bag('light red bags'))
    assert_equal(:shiny_gold, @hh.parse_bag('shiny gold bags'))
    assert_equal(:dark_olive, @hh.parse_bag(%w[dark olive bags]))
    assert_equal(:dotted_black, @hh.parse_bag(%w[dotted black bags]))
  end

  def test_parse
    rules = @hh.parse(BAGS)
    assert_equal({}, rules[:dotted_black])
    assert_equal({ shiny_gold: 1 }, rules[:bright_white])
    assert_equal({ dark_olive: 1, vibrant_plum: 2 }, rules[:shiny_gold])
  end

  def test_contains?
    rules = @hh.parse(BAGS)
    assert(@hh.contains?(:bright_white, :shiny_gold, rules))
    refute(@hh.contains?(:dotted_black, :shiny_gold, rules))
    assert(@hh.contains?(:light_red, :shiny_gold, rules))
    refute(@hh.contains?(:vibrant_plum, :shiny_gold, rules))
  end

  def test_count_contains
    rules = @hh.parse(BAGS)
    assert_equal(4, @hh.count_contains(:shiny_gold, rules))
  end

  def test_count_all
    rules = @hh.parse(BAGS)
    assert_equal(33, @hh.count_all(:shiny_gold, rules))

    rules = @hh.parse(BAGS2)
    assert_equal(127, @hh.count_all(:shiny_gold, rules))
  end

  def test_count_in
    rules = @hh.parse(BAGS)
    assert_equal(32, @hh.count_in(:shiny_gold, rules))

    rules = @hh.parse(BAGS2)
    assert_equal(126, @hh.count_in(:shiny_gold, rules))
  end
end
