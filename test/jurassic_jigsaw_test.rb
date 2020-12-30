# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/jurassic_jigsaw'

class AOC2020::JurassicJigsawTest < MiniTest::Test
  TILE_2311 = <<~EOTILE2311
    Tile 2311:
    ..##.#..#.
    ##..#.....
    #...##..#.
    ####.#...#
    ##.##.###.
    ##...#.###
    .#.#.#..##
    ..#....#..
    ###...#.#.
    ..###..###
  EOTILE2311

  IMAGE = <<~EOIMAGE.chomp
    .#.#..#.##...#.##..#####
    ###....#.#....#..#......
    ##.##.###.#.#..######...
    ###.#####...#.#####.#..#
    ##.#....#.##.####...#.##
    ...########.#....#####.#
    ....#..#...##..#.#.###..
    .####...#..#.....#......
    #..#.##..#..###.#.##....
    #.####..#.####.#.#.###..
    ###.#.#...#.######.#..##
    #.####....##..########.#
    ##..##.#...#...#.#.#.#..
    ...#..#..#.#.##..###.###
    .#.#....#.##.#...###.##.
    ###.#...#..#.##.######..
    .#.#.###.##.##.#..#.##..
    .####.###.#...###.#..#.#
    ..#.#..#..#.#.#.####.###
    #..####...#.#.#.###.###.
    #####..#####...###....##
    #.##..#..#...#..####...#
    .#.###..##..##..####.##.
    ...###...##...#...#..###
  EOIMAGE

  def setup
    @tiles = File.read('test/fixtures/jurassic_jigsaw.txt').chomp
  end

  def test_setup_and_finding_corners
    image = AOC2020::JurassicJigsaw::Image.new(@tiles)
    corners = image.corners.map(&:id).sort
    assert_equal([1171, 1951, 2971, 3079], corners)
  end

  def test_tile_flip_h!
    tile = AOC2020::JurassicJigsaw::Tile.new(TILE_2311)
    assert_equal(
      [
        '.#..#.##..',
        '.....#..##',
        '.#..##...#',
        '#...#.####',
        '.###.##.##',
        '###.#...##',
        '##..#.#.#.',
        '..#....#..',
        '.#.#...###',
        '###..###..'
      ],
      tile.flip_h!
    )
  end

  def test_tile_flip_v!
    tile = AOC2020::JurassicJigsaw::Tile.new(TILE_2311)
    assert_equal(
      [
        '..###..###',
        '###...#.#.',
        '..#....#..',
        '.#.#.#..##',
        '##...#.###',
        '##.##.###.',
        '####.#...#',
        '#...##..#.',
        '##..#.....',
        '..##.#..#.'
      ],
      tile.flip_v!
    )
  end

  def test_tile_make_me_top_left!
    image = AOC2020::JurassicJigsaw::Image.new(@tiles)
    tile = image.tiles[2311]
    refute(tile.make_me_top_left!)

    tile = image.tiles[3079]
    img_save = image.tiles[3079].img.dup
    assert(tile.make_me_top_left!)
    assert_equal(%i[top left], tile.uniq_borders)
    assert_equal(img_save.map(&:reverse), tile.img)
  end

  def test_grid!
    image = AOC2020::JurassicJigsaw::Image.new(@tiles)
    img = image.grid!
    assert_equal(
      [
        [1951, 2311, 3079],
        [2729, 1427, 2473],
        [2971, 1489, 1171]
      ],
      img.map { |row| row.map(&:id) }
    )
  end

  def test_image!
    image = AOC2020::JurassicJigsaw::Image.new(@tiles)
    assert_equal(IMAGE, image.image!)
  end
end
