# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class TobogganTrajectory < Day
    def setup
      @input = read_map(read_input_file)
    end

    def part1
      puts "Part 1: #{count_trees_for_trajectory(@input, 3, 1)}"
    end

    def count_trees_for_trajectory(map, right, down)
      width = map[0].length
      height = map.length
      x = 0
      y = 0
      trees = 0
      loop do
        trees += 1 if map[y][x] == '#'
        x = (x + right) % width
        y += down
        break trees if y >= height
      end
    end

    def read_map(input)
      input.split.map(&:chars)
    end
  end
end
