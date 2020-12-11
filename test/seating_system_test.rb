# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/seating_system'

class AOC2020::SeatingSystemTest < MiniTest::Test
  MAP = <<~EOMAP
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
  EOMAP

  STEP1 = <<~EOST1
    #.##.##.##
    #######.##
    #.#.#..#..
    ####.##.##
    #.##.##.##
    #.#####.##
    ..#.#.....
    ##########
    #.######.#
    #.#####.##
  EOST1

  STEP2 = <<~EOST2
    #.LL.L#.##
    #LLLLLL.L#
    L.L.L..L..
    #LLL.LL.L#
    #.LL.LL.LL
    #.LLLL#.##
    ..L.L.....
    #LLLLLLLL#
    #.LLLLLL.L
    #.#LLLL.##
  EOST2

  EIGHT = <<~EOEIGHT
    .......#.
    ...#.....
    .#.......
    .........
    ..#L....#
    ....#....
    .........
    #........
    ...#.....
  EOEIGHT

  EMPTY = <<~EOEMPTY
    .............
    .L.L.#.#.#.#.
    .............
  EOEMPTY

  NONE = <<~EONONE
    .##.##.
    #.#.#.#
    ##...##
    ...L...
    ##...##
    #.#.#.#
    .##.##.
  EONONE

  def setup
    @ss = AOC2020::SeatingSystem.new
  end

  def test_parse_map
    map = @ss.parse_map(MAP)
    assert_equal('L.LL.LL.LL', map[0])
    assert_equal('L.LLLLL.LL', map[9])
  end

  def test_step
    map = @ss.parse_map(MAP)

    new_map, changed = @ss.step(map)
    assert_equal(@ss.parse_map(MAP), map)
    assert_equal(@ss.parse_map(STEP1), new_map)
    assert(changed)

    map, changed = @ss.step(new_map)
    assert_equal(@ss.parse_map(STEP1), new_map)
    assert_equal(@ss.parse_map(STEP2), map)
    assert(changed)
  end

  def test_get_neighbours
    map = @ss.parse_map(EIGHT)
    assert_equal(%w[# #], @ss.get_neighbours(map, 3, 4, false))
    assert_equal(['#'] * 8, @ss.get_neighbours(map, 3, 4, true))

    map = @ss.parse_map(EMPTY)
    assert_equal([], @ss.get_neighbours(map, 1, 1, false))
    assert_equal(['L'], @ss.get_neighbours(map, 1, 1, true))
    assert_equal(%w[# L], @ss.get_neighbours(map, 3, 1, true))

    map = @ss.parse_map(NONE)
    assert_equal([], @ss.get_neighbours(map, 3, 3, false))
    assert_equal([], @ss.get_neighbours(map, 3, 3, true))
  end

  def test_count_seats
    assert_equal(0, @ss.count_seats(@ss.parse_map(MAP)))
    assert_equal(71, @ss.count_seats(@ss.parse_map(STEP1)))
    assert_equal(20, @ss.count_seats(@ss.parse_map(STEP2)))
  end
end
