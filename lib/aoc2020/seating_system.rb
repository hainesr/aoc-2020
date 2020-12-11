# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class SeatingSystem < Day
    def setup
      @input = parse_map(read_input_file)
    end

    def part1
      map = @input

      done = loop do
        map, changed = step(map)
        break map unless changed
      end

      puts "Part 1: #{count_seats(done)}"
    end

    def step(map)
      new_map = map.map(&:dup)
      changed = false

      height = map.length
      width = map[0].length

      height.times do |y|
        width.times do |x|
          neighbours = get_neighbours(map, x, y)
          case map[y][x]
          when 'L'
            unless neighbours.include?('#')
              new_map[y][x] = '#'
              changed = true
            end
          when '#'
            if neighbours.count { |n| n == '#' } >= 4
              new_map[y][x] = 'L'
              changed = true
            end
          end
        end
      end

      [new_map, changed]
    end

    def count_seats(map)
      map.join.count('#')
    end

    def get_neighbours(map, x, y)
      neighbours = []
      [
        [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]
      ].each do |direction|
        nx = x + direction[0]
        ny = y + direction[1]

        next if !(0...map.length).cover?(ny) || !(0...map[0].length).cover?(nx)

        n = map[ny][nx]
        neighbours << n if %w[L #].include?(n)
      end

      neighbours
    end

    def parse_map(input)
      input.split
    end
  end
end
