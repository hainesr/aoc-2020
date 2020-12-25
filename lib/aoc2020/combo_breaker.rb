# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class ComboBreaker < Day
    MOD = 20_201_227
    KEYS = [
      14_205_034,
      18_047_856
    ].freeze

    def part1
      p find_enc_key(KEYS)
    end

    def find_enc_key(keys)
      loops = crack_loop(7, keys[1])

      transform(keys[0], loops)
    end

    def transform(subject, loop_size)
      value = 1

      loop_size.times do
        value = ((value * subject) % MOD)
      end

      value
    end

    def crack_loop(subject, key)
      value = 1
      loops = 1

      loop do
        value = ((value * subject) % MOD)
        return loops if value == key

        loops += 1
      end
    end
  end
end
