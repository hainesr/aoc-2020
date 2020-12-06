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
      puts "Part 1: #{simple_counts(@input).sum}"
    end

    def part2
      puts "Part 2: #{inclusive_counts(@input).sum}"
    end

    def simple_counts(groups)
      groups.map { |g| g.flatten.uniq.count }
    end

    def inclusive_counts(groups)
      groups.map do |g|                         # For each group:
        size = g.length                         # * note the group size;
        f = g.flatten                           # * combine all declarations;
        s = f.group_by { |x| f.count(x) }[size] # * keep those dec'd size times;
        s.nil? ? 0 : s.uniq.length              # * count the unique decs.
      end
    end

    def parse(input)
      input.split("\n\n").map { |g| g.split.map(&:chars) }
    end
  end
end
