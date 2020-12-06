# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class CustomCustoms < Day
    def setup
      @input = parse(read_input_file)
    end

    def part1
      puts "Part 1: #{counts(@input).sum}"
    end

    def counts(groups)
      groups.map { |g| g.uniq.count }
    end

    def parse(input)
      input.split("\n\n").map { |g| g.tr("\n", '').chars }
    end
  end
end
