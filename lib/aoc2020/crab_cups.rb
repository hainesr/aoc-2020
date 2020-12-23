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
      puts "Part 1: #{play(LABELS).join}"
    end

    # rubocop:disable Style/WhileUntilModifier
    def play(cups, turns = 100, num_cups = nil)
      num_cups = num_cups.nil? ? cups.length : num_cups

      # `on_right` is a circular list that gives the index of the next cup.
      # I wanted to call this `next` but that is a ruby keyword.
      on_right = circle(cups, num_cups)

      curr = cups[0]

      loop do
        # Get the three cups after the current position.
        take1 = on_right[curr]
        take2 = on_right[take1]
        take3 = on_right[take2]
        after_take = on_right[take3]

        # Find the destination cup.
        dest = curr == 1 ? num_cups : curr - 1
        while dest == take1 || dest == take2 || dest == take3
          dest = dest == 1 ? num_cups : dest - 1
        end

        # Remove the three cups.
        on_right[curr] = after_take

        # Insert the three cups.
        right_of_dest = on_right[dest]
        on_right[dest] = take1
        on_right[take3] = right_of_dest

        # Move to the next cup.
        curr = after_take
        turns -= 1
        break if turns.zero?
      end

      # Return the numbers immediately after 1 in the circle.
      curr = 1
      (cups.length - 1).times.map { curr = on_right[curr] }
    end
    # rubocop:enable Style/WhileUntilModifier

    private

    def circle(cups, num_cups)
      list = Array.new(num_cups) { |i| i + 1 }
      cups.each_cons(2) { |l, r| list[l] = r }
      if num_cups > cups.length
        # On the right of the last initial cup is the next index.
        list[cups[-1]] = cups.length + 1

        # On the right of the last cup is the first cup.
        list[num_cups] = cups[0]
      else
        # On the right of the last cup is the first cup.
        list[cups[-1]] = cups[0]
      end

      list
    end
  end
end
