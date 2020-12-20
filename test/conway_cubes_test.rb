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
    assert_equal([[0, 1, 0], [0, 0, 1], [1, 1, 1]], @cc.parse(INPUT))
  end

  def test_count
    grid = @cc.parse(INPUT)
    cube = @cc.init_cube(grid, 7)
    assert_equal(5, cube.count)
    cube.step
    assert_equal(11, cube.count)
  end

  def test_step
    grid = @cc.parse(INPUT)
    cube = @cc.init_cube(grid, 17)
    6.times do
      cube.step
    end
    assert_equal(112, cube.count)
  end
end
