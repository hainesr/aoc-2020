# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class AdapterArray < Day
    def setup
      @input = read_adapters(read_input_file)
    end

    def part1
      diffs = jolt_steps
      puts "Part 1: #{diffs[1] * diffs[3]}"
    end

    def jolt_steps(adapters = @input)
      adapters.each_cons(2).map { |i, j| j - i }.tally
    end

    def read_adapters(list)
      adapters = list.split.map(&:to_i).sort
      adapters.unshift(0)
      adapters << adapters.last + 3
      adapters
    end
  end
end
