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

    def next_bus(input = @input)
      time = earliest_time(input)
      services = running_services(input)
      next_times = services.map { |x| [x, x - (time % x)] }
      next_times.min_by { |_, t| t }
    end

    def earliest_time(input)
      input.first.to_i
    end

    def running_services(input)
      input.last.split(',').map(&:to_i).delete_if(&:zero?)
    end
  end
end
