# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class DockingData < Day
    def setup
      @input = load(read_input_file)
    end

    def part1
      puts "Part 1: #{compute}"
    end

    def compute(program = @input)
      mem = {}
      and_mask = 0
      or_mask = 0

      program.each do |line|
        if line[0] == :mask
          and_mask, or_mask = line[2..]
          next
        end

        mem[line[1]] = (line[2] & and_mask) | or_mask
      end

      mem.values.sum
    end

    def load(input)
      input.split("\n").map do |line|
        tokens = line.split(' = ')
        tokens[0] == 'mask' ? parse_mask(tokens) : parse_mem(tokens)
      end
    end

    def parse_mask(input)
      and_mask = input[1].tr('X', '1').to_i(2)
      or_mask = input[1].tr('X', '0').to_i(2)
      [:mask, input[1], and_mask, or_mask]
    end

    def parse_mem(input)
      location = input[0].split('[').last.chomp(']').to_i
      value = input[1].to_i
      [:mem, location, value]
    end
  end
end
