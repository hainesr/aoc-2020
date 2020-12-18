# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class OperationOrder < Day
    INNER = Regexp.compile(/\([^()]+\)/)

    def setup
      @input = read_input_file.split("\n")
    end

    def part1
      total = @input.map { |line| eval_line(line) }.sum
      puts "Part 1: #{total}"
    end

    def eval_line(line)
      nested = INNER.match(line)
      return eval_part(line.split).to_i if nested.nil?

      start, finish = nested.offset(0)
      part = nested[0][1...-1]
      eval_line(line[0...start] + eval_part(part.split) + line[finish..])
    end

    def eval_part(part)
      return part.first if part.length == 1

      x, op, y = part[0..2]
      sum = if op == '+'
              x.to_i + y.to_i
            else
              x.to_i * y.to_i
            end
      new_part = part[3..].unshift(sum.to_s)

      eval_part(new_part)
    end
  end
end
