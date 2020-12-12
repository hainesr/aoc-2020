# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class SeatingSystem < Day
    ADJ8 = [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]

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
      sight = sightlines(@input)

      done = loop do
        map, changed = step(map, sight)
        break map unless changed
      end

      puts "Part 2: #{count_seats(done)}"
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def step(map, sight = nil)
      threshold = sight.nil? ? 4 : 5
      changed = false

      new_map = map.map.with_index do |row, y|
        row.map.with_index do |seat, x|
          next seat unless %w[L #].include?(seat)

          neighbours = (sight.nil? ? ADJ8 : sight[y][x]).count do |dy, dx|
            map[y + dy][x + dx] == '#'
          end

          if seat == 'L' && neighbours.zero?
            changed = true
            '#'
          elsif seat == '#' && neighbours >= threshold
            changed = true
            'L'
          else
            seat
          end
        end
      end

      [new_map, changed]
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    def count_seats(map)
      map.join.count('#')
    end

    def sightlines(map)
      map.map.with_index do |row, j|
        row.map.with_index do |seat, i|
          seat != '!' && ADJ8.map do |dx, dy|
            x = dx + i
            y = dy + j
            (x += dx) && (y += dy) while map[y][x] == '.'

            [y - j, x - i]
          end
        end
      end
    end

    def parse_map(input)
      map = input.split.map { |x| "!#{x}!" }
      map.unshift('!' * map[0].length)
      map << '!' * map[0].length
      map.map(&:chars)
    end
  end
end
