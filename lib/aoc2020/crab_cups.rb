# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class CrabCups < Day
    LABELS = [1, 3, 7, 8, 2, 6, 4, 9, 5].freeze

    def part1
      puts "Part 1: #{result(play(LABELS))}"
    end

    def play(cups, turns = 100)
      cups = cups.dup
      curr_i = 0

      loop do
        current, x, y, z, *rest = cups.rotate(curr_i)
        three = [x, y, z]
        sub = 1
        dest_i = loop do
          i = rest.index(current - sub)
          break i unless i.nil?

          sub += 1
          break rest.index(rest.max) if (current - sub) < rest.min
        end + 1

        cups = rest.insert(dest_i, three).flatten.unshift(current).rotate(-curr_i)

        curr_i = (curr_i + 1) % cups.length
        turns -= 1
        return cups if turns == 0
      end
    end

    def result(cups)
      cups.rotate(cups.index(1))[1..].join
    end
  end
end
