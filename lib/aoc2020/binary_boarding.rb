# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class BinaryBoarding < Day
    ROWS = 127
    COLUMNS = 7

    def setup
      input = read_input_file.split
      @all_ids = input.map { |code| seat_number(code)[2] }
    end

    def part1
      max_id = @all_ids.max

      puts "Part 1: #{max_id}"
    end

    def part2
      seat = @all_ids.each do |id|
        break id + 1 if !@all_ids.include?(id + 1) && @all_ids.include?(id + 2)
      end

      puts "Part 2: #{seat}"
    end

    def seat_number(code)
      code = code.chars
      row_min = 0
      row_max = ROWS
      col_min = 0
      col_max = COLUMNS

      code.each do |c|
        new_row_range = (row_max - row_min) / 2
        new_col_range = (col_max - col_min) / 2
        case c
        when 'F'
          row_max = row_min + new_row_range
        when 'B'
          row_min = row_min + new_row_range + 1
        when 'R'
          col_min = col_min + new_col_range + 1
        when 'L'
          col_max = col_min + new_col_range
        end
      end

      [row_min, col_min, (row_min * 8) + col_min]
    end
  end
end
