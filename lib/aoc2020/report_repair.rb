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
      puts "Part 1: #{sum2(@input)}"
    end

    def part2
      result = sum3(@input).reduce(1, &:*)
      puts "Part 2: #{result}"
    end

    def sum2(list)
      num = list.each do |n|
        break n if list.include?(2020 - n)
      end

      num * (2020 - num)
    end

    def sum3(list)
      list.each do |x|
        sum = 2020 - x
        (list - [x]).each do |y|
          return [x, y, (sum - y)] if list.include?(sum - y)
        end
      end
    end
  end
end
