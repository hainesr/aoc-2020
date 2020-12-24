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
end
