# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class ShuttleSearch < Day
    def setup
      @input = read_input_file.split
    end

    def part1
      bus = next_bus
      puts "Part 1: #{bus[0] * bus[1]}"
    end

    def part2
      puts "Part 2: #{contest}"
    end

    def next_bus(input = @input)
      time = earliest_time(input)
      services = running_services(input)
      next_times = services.map { |x| [x, x - (time % x)] }
      next_times.min_by { |_, t| t }
    end

    def contest(input = @input)
      buses = buses_with_offset(input)

      # Periodicity is the bus ID; timestamp is the offset in the list of buses.
      periodicity, timestamp = buses[0]
      buses[1..].each do |bus|
        while ((timestamp + bus[1]) % bus[0]) != 0
          timestamp += periodicity # Line up the offset.
        end
        periodicity *= bus[0] # Multiply in the new periodicity.
      end

      timestamp
    end

    def earliest_time(input)
      input.first.to_i
    end

    def running_services(input)
      input.last.split(',').map(&:to_i).delete_if(&:zero?)
    end

    def buses_with_offset(input)
      input.last.split(',').map.with_index do |id, i|
        id == 'x' ? nil : [id.to_i, i]
      end.compact
    end
  end
end
