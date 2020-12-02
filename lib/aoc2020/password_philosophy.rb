# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class PasswordPhilosophy < Day
    def setup
      @input = parse(read_input_file.split("\n"))
    end

    def part1
      num_valid = @input.count { |line| valid?(line) }
      puts "Part 1: #{num_valid}"
    end

    def valid?(line)
      token, min, max, password = line
      count = password.count(token)
      count >= min && count <= max
    end

    def parse(list)
      list.map do |line|
        tokens = line.split
        min, max = tokens[0].split('-').map(&:to_i)
        [tokens[1][0], min, max, tokens[2]]
      end
    end
  end
end
