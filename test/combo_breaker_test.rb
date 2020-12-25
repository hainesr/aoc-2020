# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/combo_breaker'

class AOC2020::ComboBreakerTest < MiniTest::Test
  CARD_KEY = 5_764_801
  DOOR_KEY = 17_807_724
  ENCR_KEY = 14_897_079

  def setup
    @cb = AOC2020::ComboBreaker.new
  end

  def test_crack_loop
    assert_equal(8, @cb.crack_loop(7, CARD_KEY))
    assert_equal(11, @cb.crack_loop(7, DOOR_KEY))
  end

  def test_transform
    assert_equal(ENCR_KEY, @cb.transform(CARD_KEY, 11))
    assert_equal(ENCR_KEY, @cb.transform(DOOR_KEY, 8))
  end

  def test_find_enc_key
    assert_equal(ENCR_KEY, @cb.find_enc_key([CARD_KEY, DOOR_KEY]))
  end
end
