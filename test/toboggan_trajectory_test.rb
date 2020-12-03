# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/toboggan_trajectory'

class AOC2020::TobogganTrajectoryTest < MiniTest::Test
  MAP = <<~EOMAP
    ..##.......
    #...#...#..
    .#....#..#.
    ..#.#...#.#
    .#...##..#.
    ..#.##.....
    .#.#.#....#
    .#........#
    #.##...#...
    #...##....#
    .#..#...#.#
  EOMAP

  def setup
    @tt = AOC2020::TobogganTrajectory.new
  end

  def test_read_map
    map = @tt.read_map(MAP)
    assert_equal(
      ['.', '.', '#', '#', '.', '.', '.', '.', '.', '.', '.'], map[0]
    )
    assert_equal(
      ['.', '#', '.', '.', '.', '#', '#', '.', '.', '#', '.'], map[4]
    )
    assert_equal(
      ['.', '#', '.', '.', '#', '.', '.', '.', '#', '.', '#'], map[10]
    )
  end

  def test_count_trees_for_trajectory
    map = @tt.read_map(MAP)
    assert_equal(7, @tt.count_trees_for_trajectory(map, 3, 1))
    assert_equal(2, @tt.count_trees_for_trajectory(map, 1, 1))
    assert_equal(3, @tt.count_trees_for_trajectory(map, 5, 1))
    assert_equal(4, @tt.count_trees_for_trajectory(map, 7, 1))
    assert_equal(2, @tt.count_trees_for_trajectory(map, 1, 2))
  end
end
