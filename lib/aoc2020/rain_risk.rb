# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class RainRisk < Day
    DIRECTIONS = [
      [0, 1],  # N
      [1, 0],  # E
      [0, -1], # S
      [-1, 0]  # W
    ].freeze

    COMPASS = %w[N E S W].freeze

    LOOKUP = COMPASS.zip(DIRECTIONS).to_h

    def setup
      @input = read_input_file.split
    end

    def part1
      location = move(@input)
      puts "Part 1: #{manhattan(location)}"
    end

    def part2
      location = move_waypoint(@input)
      puts "Part 2: #{manhattan(location)}"
    end

    def manhattan(location)
      location.map(&:abs).sum
    end

    def move(directions)
      location = [0, 0] # Start at origin.
      facing = 1 # Start looking East.

      directions.each do |direction|
        dir = direction[0]
        magnitude = direction.slice(1, 3).to_i

        move = case dir
               when 'F'
                 DIRECTIONS[facing]
               when /[NESW]/
                 LOOKUP[dir]
               when 'R'
                 facing = (facing + (magnitude / 90)) % 4
                 [0, 0]
               when 'L'
                 facing = (facing - (magnitude / 90)) % 4
                 [0, 0]
               end

        [0, 1].each do |i|
          location[i] += (move[i] * magnitude)
        end
      end

      location
    end

    def move_waypoint(directions)
      location = [0, 0] # Start at origin.
      waypoint = [10, 1]

      directions.each do |direction|
        dir = direction[0]
        magnitude = direction.slice(1, 3).to_i

        case dir
        when 'F'
          [0, 1].each do |i|
            location[i] += (waypoint[i] * magnitude)
          end
        when /[NESW]/
          [0, 1].each do |i|
            waypoint[i] += (LOOKUP[dir][i] * magnitude)
          end
        when 'R'
          (magnitude / 90).times do
            waypoint[0], waypoint[1] = [waypoint[1], -waypoint[0]]
          end
        when 'L'
          (magnitude / 90).times do
            waypoint[0], waypoint[1] = [-waypoint[1], waypoint[0]]
          end
        end
      end

      location
    end
  end
end
