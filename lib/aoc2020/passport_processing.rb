# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class PassportProcessing < Day
    def setup
      @input = parse(read_input_file)
    end

    def part1
      valid = @input.count { |passport| valid?(passport) }
      puts "Part 1: #{valid}"
    end

    def valid?(passport)
      return true if passport.length == 8
      return true if passport.length == 7 && !passport.key?('cid')

      false
    end

    def parse(input)
      passports = input.split("\n\n").map(&:split)
      passports.map do |fields|
        fields.map { |f| f.split(':') }.to_h
      end
    end
  end
end
