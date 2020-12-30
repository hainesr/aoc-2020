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
    @jj = AOC2020::JurassicJigsaw.new
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

  def test_monster_coords
    assert_equal(
      [
        [18, 0],
        [0, 1], [5, 1], [6, 1], [11, 1], [12, 1], [17, 1], [18, 1], [19, 1],
        [1, 2], [4, 2], [7, 2], [10, 2], [13, 2], [16, 2]
      ],
      @jj.monster_coords
    )
  end

  def test_count_monsters
    assert_equal(0, @jj.count_monsters("#.#\n.#."))

    assert_equal(
      1,
      @jj.count_monsters(
        "####################\n####################\n####################",
        rotate: false
      )
    )

    image = AOC2020::JurassicJigsaw::Image.new(@tiles).image!
    assert_equal(2, @jj.count_monsters(image))
  end
end
