# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/jurassic_jigsaw'

class AOC2020::JurassicJigsawTest < MiniTest::Test
  def setup
    @tiles = File.read('test/fixtures/jurassic_jigsaw.txt').chomp
  end

  def test_setup_and_finding_corners
    image = AOC2020::JurassicJigsaw::Image.new(@tiles)
    corners = image.corners.map(&:id).sort
    assert_equal([1171, 1951, 2971, 3079], corners)
  end
end
