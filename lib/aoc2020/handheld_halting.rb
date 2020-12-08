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
      puts "Part 1: #{execute(@input)[1]}"
    end

    def part2
      puts "Part 2: #{fix(@input)}"
    end

    def execute(program)
      pc = 0
      acc = 0
      seen = [program.length] # Normal termination at the end of the program.

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

      [pc, acc]
    end

    def fix(program)
      (0...program.length).each do |i|
        case program[i][0]
        when :nop
          program[i][0] = :jmp
          pc, acc = execute(program)
          program[i][0] = :nop
        when :jmp
          program[i][0] = :nop
          pc, acc = execute(program)
          program[i][0] = :jmp
        end

        return acc if pc == program.length
      end
    end

    def load(program)
      program.split("\n").map do |line|
        op, param = line.split
        [op.to_sym, param.to_i]
      end
    end
  end
end
