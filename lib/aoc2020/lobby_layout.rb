# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

# Use a "cube" coordinate system, as described here:
# https://www.redblobgames.com/grids/hexagons/
# Note that for each coordinate, `[x, y, z]`, `x + y + z == 0`.
module AOC2020
  class LobbyLayout < Day
    DIR = /[ns]?[ew]/.freeze
    LINE = /^(#{DIR})+$/.freeze
    ADJ6 = [-1, 0, 1].permutation(3).to_a.freeze
    ADJ7 = [[0, 0, 0]] + ADJ6.freeze

    def setup
      @coords = read_input(read_input_file)
    end

    def part1
      black = @coords.length - (@coords.length - @coords.uniq.length) * 2
      puts "Part 1: #{black}"
    end

    def part2
      tiles = run_floor(init_tiles(@coords), 100)
      puts "Part 2: #{tiles.values.sum}"
    end

    # rubocop:disable Metrics/PerceivedComplexity
    def run_floor(tiles, days)
      loop do
        n_tiles = {}

        tiles.each do |(tx, ty, tz), _|
          ADJ7.each do |(nx, ny, nz)|
            coord = [x = tx + nx, y = ty + ny, z = tz + nz].freeze
            next if n_tiles.key?(coord)

            nbours = ADJ6.sum do |(dx, dy, dz)|
              tiles.fetch([x + dx, y + dy, z + dz], 0)
            end

            n_tiles[coord] = if nbours == 2
                               1
                             else
                               tiles[coord] == 1 && nbours == 1 ? 1 : 0
                             end
          end
        end

        days -= 1
        tiles = n_tiles.select { |_, v| v == 1 }
        return tiles if days.zero?
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity

    def init_tiles(coords)
      coords.each_with_object({}) { |c, obj| obj[c] = (obj.key?(c) ? 0 : 1) }
    end

    def read_input(input)
      input.split.map do |line|
        next [] unless LINE.match(line)

        x = y = z = 0
        line.scan(DIR) do |dir|
          case dir
          when 'ne'
            x += 1
            z -= 1
          when 'e'
            x += 1
            y -= 1
          when 'se'
            y -= 1
            z += 1
          when 'sw'
            x -= 1
            z += 1
          when 'w'
            x -= 1
            y += 1
          when 'nw'
            y += 1
            z -= 1
          end
        end

        [x, y, z]
      end
    end
  end
end
