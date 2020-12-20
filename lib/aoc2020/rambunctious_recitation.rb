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
      game = Game.new(INPUT)
      puts "Part 1: #{game.play_to(2020)}"
    end

    class Game
      def initialize(starting_numbers)
        @starting_numbers = starting_numbers
        @turn = 0
        @last_spoken = nil
        @cache = {}
      end

      def play_to(upto)
        loop do
          turn, number = take_turn
          return number if turn == upto
        end
      end

      def take_turn
        if @turn < @starting_numbers.length
          number = @starting_numbers[@turn]
        else
          history = @cache[@last_spoken]
          number = (history.length == 1 ? 0 : history[0] - history[1])
        end

        @turn += 1
        say(number)

        [@turn, number]
      end

      def say(number)
        @cache[number] ||= []
        @cache[number].unshift(@turn)
        @last_spoken = number
      end
    end
  end
end
