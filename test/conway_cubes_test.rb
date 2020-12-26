# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/conway_cubes'

class AOC2020::ConwayCubesTest < MiniTest::Test
  INPUT = <<~EOINPUT
    .#.
    ..#
    ###
  EOINPUT

  def setup
    @cc = AOC2020::ConwayCubes.new
  end

  def test_parse
    assert_equal(
      {
        [1, 0, 0] => 1,
        [2, 1, 0] => 1,
        [0, 2, 0] => 1,
        [1, 2, 0] => 1,
        [2, 2, 0] => 1
      },
      @cc.parse(INPUT)
    )
  end

  def test_parse_w
    assert_equal(
      {
        [1, 0, 0, 0] => 1,
        [2, 1, 0, 0] => 1,
        [0, 2, 0, 0] => 1,
        [1, 2, 0, 0] => 1,
        [2, 2, 0, 0] => 1
      },
      @cc.parse(INPUT, w: true)
    )
  end

  def test_boot
    coords = @cc.parse(INPUT)
    coords_save = coords.dup
    assert_equal(112, @cc.boot(coords).values.sum)
    assert_equal(coords_save, coords)
  end

  def test_boot_w
    coords = @cc.parse(INPUT, w: true)
    coords_save = coords.dup
    assert_equal(29, @cc.boot(coords, 1).values.sum)
    assert_equal(60, @cc.boot(coords, 2).values.sum)
    # assert_equal(848, @cc.boot(coords).values.sum)
    assert_equal(coords_save, coords)
  end
end
