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
      @input = read_input_file.split.map(&:to_i)
    end

    def part1
      diffs = jolt_steps
      puts "Part 1: #{diffs[0] * diffs[1]}"
    end

    def jolt_steps(adapters = @input)
      adapters = adapters.dup.sort
      adapters << adapters.last + 3
      diffs = []

      prev = 0
      adapters.each do |adapter|
        diffs << adapter - prev
        prev = adapter
      end

      diffs.group_by { |x| x }.values.map(&:length)
    end
  end
end
