# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class CrabCombat < Day
    def setup
      @decks = read_decks(read_input_file)
    end

    def part1
      result = play(@decks)
      puts "Part 1: #{score(result)}"
    end

    def play(decks, finish: true)
      player1, player2 = decks.map(&:dup)

      loop do
        p1 = player1.shift
        p2 = player2.shift

        if p1 > p2
          player1 << p1 << p2
          return player1 if player2.empty?
        else
          player2 << p2 << p1
          return player2 if player1.empty?
        end

        break unless finish
      end

      [player1, player2]
    end

    def score(deck)
      i = 0
      deck.reverse.sum do |s|
        i += 1
        s * i
      end
    end

    def read_decks(input)
      input.split("\n\n").map do |deck|
        deck.split("\n").map do |card|
          next if card.start_with?('P')

          card.to_i
        end.compact
      end
    end
  end
end
