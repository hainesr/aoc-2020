# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class HandheldHalting < Day
    def setup
      @input = load(read_input_file)
    end

    def part1
      puts "Part 1: #{execute(@input)}"
    end

    def execute(program)
      pc = 0
      acc = 0
      seen = []

      loop do
        break if seen.include?(pc)

        seen << pc
        op, param = program[pc]

        case op
        when :nop
          pc += 1
        when :acc
          acc += param
          pc += 1
        when :jmp
          pc += param
        end
      end

      acc
    end

    def load(program)
      program.split("\n").map do |line|
        op, param = line.split
        [op.to_sym, param.to_i]
      end
    end
  end
end
