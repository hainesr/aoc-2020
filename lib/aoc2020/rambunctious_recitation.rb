# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class RambunctiousRecitation < Day
    INPUT = [5, 1, 9, 18, 13, 8, 0].freeze

    def part1
      puts "Part 1: #{play_to(2020)}"
    end

    def part2
      puts "Part 2: #{play_to(30_000_000)}"
    end

    def play_to(upto, starting_numbers = INPUT)
      turn = 0
      last_spoken = nil
      cache = Array.new(upto)

      loop do
        if turn < starting_numbers.length
          last_spoken = starting_numbers[turn]
          cache[last_spoken] = turn + 1
        else
          history = cache[last_spoken]
          cache[last_spoken] = turn
          last_spoken = (history.nil? ? 0 : turn - history)
        end

        turn += 1
        return last_spoken if turn == upto
      end
    end
  end
end
