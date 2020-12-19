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

    def part2
      total = @input.map { |line| eval_line(line, true) }.sum
      puts "Part 2: #{total}"
    end

    # rubocop:disable Style/OptionalBooleanParameter
    def eval_line(line, pt2 = false)
      eval_line_impl(line, pt2).to_i
    end
    # rubocop:enable Style/OptionalBooleanParameter

    def eval_line_impl(line, pt2)
      nested = INNER.match(line)
      return eval_part(line.split, pt2) if nested.nil?

      start, finish = nested.offset(0)
      part = nested[0][1...-1]
      eval_line_impl(
        line[0...start] + eval_part(part.split, pt2) + line[finish..], pt2
      )
    end

    # rubocop:disable Style/OptionalBooleanParameter
    def eval_part(part, pt2 = false)
      return part.first if part.length == 1

      if pt2 && (%w[+ *] - part).empty?
        i = part.index('+')
        part.insert(i + 2, ')').insert(i - 1, '(')
        return eval_line_impl(part.join(' '), pt2)
      end

      x, op, y = part[0..2]
      sum = if op == '+'
              x.to_i + y.to_i
            else
              x.to_i * y.to_i
            end
      new_part = part[3..].unshift(sum.to_s)

      eval_part(new_part, pt2)
    end
    # rubocop:enable Style/OptionalBooleanParameter
  end
end
