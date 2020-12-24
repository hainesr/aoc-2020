# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/lobby_layout'

class AOC2020::LobbyLayoutTest < MiniTest::Test
  INPUT = <<~EOINPUT
    sesenwnenenewseeswwswswwnenewsewsw
    neeenesenwnwwswnenewnwwsewnenwseswesw
    seswneswswsenwwnwse
    nwnwneseeswswnenewneswwnewseswneseene
    swweswneswnenwsewnwneneseenw
    eesenwseswswnenwswnwnwsewwnwsene
    sewnenenenesenwsewnenwwwse
    wenwwweseeeweswwwnwwe
    wsweesenenewnwwnwsenewsenwwsesesenwne
    neeswseenwwswnwswswnw
    nenwswwsewswnenenewsenwsenwnesesenew
    enewnwewneswsewnwswenweswnenwsenwsw
    sweneswneswneneenwnewenewwneswswnese
    swwesenesewenwneswnwwneseswwne
    enesenwswwswneneswsenwnewswseenwsese
    wnwnesenesenenwwnenwsewesewsesesew
    nenewswnwewswnenesenwnesewesw
    eneswnwswnwsenenwnwnwwseeswneewsenese
    neswnwewnwnwseenwseesewsenwsweewe
    wseweeenwnesenwwwswnew
  EOINPUT

  def setup
    @ll = AOC2020::LobbyLayout.new
  end

  def test_read_input
    assert_equal([[0, 0, 0]], @ll.read_input('nwwswee'))
    assert_equal([[0, 0, 0]], @ll.read_input('nweneswwse'))
    assert_equal([[2, 0, -2]], @ll.read_input('nwene'))
    assert_equal([[-2, 0, 2]], @ll.read_input('swwse'))

    coords = @ll.read_input(INPUT)
    assert_equal(20, coords.length)
    assert_equal([-3, 0, 3], coords[2])
    coords.each do |x, y, z|
      assert_equal(0, x + y + z)
    end
  end

  def test_init_tiles
    coords = @ll.read_input(INPUT)
    tiles = @ll.init_tiles(coords)
    assert_equal(15, tiles.size)
    assert_equal(10, tiles.values.sum)
  end

  def test_run_floor
    coords = @ll.read_input(INPUT)
    tiles = @ll.init_tiles(coords)

    tiles = @ll.run_floor(tiles, 1)
    assert_equal(15, tiles.values.sum)
    assert_equal(15, tiles.length)

    tiles = @ll.run_floor(tiles, 1)
    assert_equal(12, tiles.values.sum)
    assert_equal(12, tiles.length)

    # The current implementation of this takes to long.
    # tiles = @ll.run_floor(tiles, 98)
    # assert_equal(2208, tiles.values.sum)
    # assert_equal(2208, tiles.length)
  end
end
