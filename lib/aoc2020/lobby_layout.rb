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

    def setup
      @coords = read_input(read_input_file)
    end

    def part1
      black = @coords.length - (@coords.length - @coords.uniq.length) * 2
      puts "Part 1: #{black}"
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
