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

    def setup
      @game = Game.new(INPUT, 30_000_000)
    end

    def part1
      puts "Part 1: #{@game.play_to(2020)}"
    end

    def part2
      puts "Part 2: #{@game.play_to(30_000_000)}"
    end

    class Game
      def initialize(starting_numbers, limit = 2020)
        @starting_numbers = starting_numbers
        @turn = 0
        @last_spoken = nil
        @cache = Array.new(limit)
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
          @cache[number] = @turn + 1
        else
          history = @cache[@last_spoken]
          @cache[@last_spoken] = @turn
          number = (history.nil? ? 0 : @turn - history)
        end

        @turn += 1
        @last_spoken = number

        [@turn, number]
      end
    end
  end
end
