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

    def part2
      map = @input

      done = loop do
        map, changed = step(map, long: true)
        break map unless changed
      end

      puts "Part 2: #{count_seats(done)}"
    end

    def step(map, long: false)
      new_map = map.map(&:dup)
      threshold = long ? 5 : 4
      changed = false

      map.length.times do |y|
        map[0].length.times do |x|
          neighbours = get_neighbours(map, x, y, long)
          case map[y][x]
          when 'L'
            unless neighbours.include?('#')
              new_map[y][x] = '#'
              changed = true
            end
          when '#'
            if neighbours.count { |n| n == '#' } >= threshold
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

    def get_neighbours(map, x, y, long)
      neighbours = []
      [
        [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]
      ].each do |direction|
        i = 1
        loop do
          nx = x + (direction[0] * i)
          ny = y + (direction[1] * i)

          break if !(0...map.length).cover?(ny) ||
                   !(0...map[0].length).cover?(nx)

          n = map[ny][nx]
          if %w[L #].include?(n)
            neighbours << n
            break
          end

          break unless long

          i += 1
        end
      end

      neighbours
    end

    def parse_map(input)
      input.split
    end
  end
end
