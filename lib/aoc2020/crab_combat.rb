# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'set'
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

    def part2
      result = play_recursive(@decks)
      puts "Part 2: #{score(result)}"
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

    def play_recursive(decks)
      player1, player2 = decks.map(&:dup)

      recurse(player1, player2, outer: true)
    end

    def score(deck)
      i = 0
      deck.reverse.sum do |s|
        i += 1
        s * i
      end
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def recurse(player1, player2, outer: false)
      cache = Set.new
      loop do
        unless cache.add?(fingerprint(player1, player2))
          return outer ? player1 : -1
        end

        p1 = player1.shift
        p2 = player2.shift
        winner = if player1.length >= p1 && player2.length >= p2
                   recurse(player1.first(p1), player2.first(p2))
                 else
                   p2 <=> p1
                 end

        if winner.negative?
          player1 << p1 << p2
          return outer ? player1 : -1 if player2.empty?
        elsif winner.positive?
          player2 << p2 << p1
          return outer ? player2 : 1 if player1.empty?
        else
          raise 'Welp! Something has gone horribly wrong.'
        end
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    def fingerprint(player1, player2)
      # This is probably as fast as anything.
      # It doesn't need to be two-way, but this is anyway.
      # Zero is chosen as the divider for the simple reason that it isn't in
      # either of the decks.
      (player1 + [0] + player2).pack('c*')
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
