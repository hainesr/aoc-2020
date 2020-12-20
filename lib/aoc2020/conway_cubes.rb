# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class ConwayCubes < Day
    def setup
      @input = parse(read_input_file)
    end

    def part1
      cube = init_cube
      6.times do
        cube.step
      end
      puts "Part 1: #{cube.count}"
    end

    def parse(input)
      input.split.map do |line|
        line.chars.map { |c| c == '#' ? 1 : 0 }
      end
    end

    def init_cube(grid = @input, dim = 0)
      size = grid.length
      map =  dim.zero? ? 14 : dim - size
      cube_size = size + map
      cube = Cube.new(cube_size)
      grid.each.with_index do |row, y|
        row.each.with_index do |cell, x|
          cube.put_coord(x + (map / 2), y + (map / 2), cube_size / 2, cell)
        end
      end
      cube
    end

    class Cube
      ADJ26 = [-1, 0, 1].product([-1, 0, 1], [-1, 0, 1]) - [[0, 0, 0]]

      def initialize(size)
        @cube = Array.new(size) { Array.new(size) { Array.new(size, 0) } }
        @dim = size
      end

      def coord(x, y, z)
        @cube[z][y][x]
      end

      def put_coord(x, y, z, state)
        @cube[z][y][x] = state
      end

      # rubocop:disable Metrics/CyclomaticComplexity
      # rubocop:disable Metrics/PerceivedComplexity
      def step
        ncube = @cube.map.with_index do |slice, z|
          next slice.dup if z.zero? || z == (@dim - 1)

          slice.map.with_index do |row, y|
            next row.dup if y.zero? || y == (@dim - 1)

            row.map.with_index do |cell, x|
              next cell if x.zero? || x == (@dim - 1)

              neighbours = get_neighbours(x, y, z)

              if cell == 1
                [2, 3].include?(neighbours) ? 1 : 0
              else
                neighbours == 3 ? 1 : 0
              end
            end
          end
        end

        @cube = ncube
      end
      # rubocop:enable Metrics/CyclomaticComplexity
      # rubocop:enable Metrics/PerceivedComplexity

      def get_neighbours(x, y, z)
        ADJ26.map do |dx, dy, dz|
          coord(x + dx, y + dy, z + dz)
        end.sum
      end

      def count
        @cube.flatten.sum
      end

      def slice_to_s(z)
        @cube[z].map do |row|
          row.map { |c| c.zero? ? '.' : '#' }.join
        end.join("\n")
      end
    end
  end
end
