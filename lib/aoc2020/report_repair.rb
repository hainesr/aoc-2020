# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

module AOC2020
  class ReportRepair < Day
    def setup
      @input = read_input_file.split.map(&:to_i)
    end

    def part1
      num = @input.each do |n|
        break n if @input.include?(2020 - n)
      end
      result = num * (2020 - num)

      puts "Part 1: #{result}"
    end
  end
end
