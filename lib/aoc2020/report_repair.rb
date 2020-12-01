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

    def part2
      result = sum3.reduce(1) { _1 * _2 }
      puts "Part 2: #{result}"
    end

    def sum3
      @input.each do |x|
        sum = 2020 - x
        (@input - [x]).each do |y|
          return [x, y, (sum - y)] if @input.include?(sum - y)
        end
      end
    end
  end
end
