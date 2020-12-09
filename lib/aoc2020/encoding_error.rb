# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class EncodingError < Day
    def setup
      @input = read_input_file.split.map(&:to_i)
    end

    def part1
      puts "Part 1: #{find_error(@input)}"
    end

    def find_error(list, preamble_size = 25)
      (preamble_size...list.length).each do |i|
        preamble_start = i - preamble_size
        preamble = list[preamble_start...(preamble_start + preamble_size)]
        return list[i] unless pass_checksum?(preamble, list[i])
      end
    end

    def pass_checksum?(list, num)
      list.each do |i|
        return true if (list - [i]).include?(num - i)
      end

      false
    end
  end
end
