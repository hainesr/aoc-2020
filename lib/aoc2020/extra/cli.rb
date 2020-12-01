# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  module Extra
    module CLI
      HEADER = 'Advent of Code 2020: '

      def self.parse_params(argv)
        return false if argv.empty?

        argv.map(&:to_i).each do |day|
          return false if day < 1 || day > 25
        end
      end

      def self.run_day(day)
        solution = AOC2020::DAY_MAP[day]
        title = day_title(solution, day)

        begin
          require ::File.join('aoc2020', solution)
        rescue StandardError
          solution = 'day'
        end

        puts title
        AOC2020.class_from_day(solution).new.run
      end

      def self.day_title(solution, day)
        if solution.nil?
          HEADER + "Day #{day}"
        else
          HEADER + solution.split('_').map(&:capitalize).join(' ')
        end
      end
    end
  end
end
