# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'benchmark'

module AOC2020
  class Day
    FORMAT = "%n #{Benchmark::FORMAT}"

    def setup; end

    def run
      setup_time = Benchmark.measure('  Setup:') { setup }
      part1_time = Benchmark.measure(' Part 1:') { part1 }
      part2_time = Benchmark.measure(' Part 2:') { part2 }

      puts
      puts "Timings: #{Benchmark::CAPTION}"
      puts setup_time.format(FORMAT)
      puts part1_time.format(FORMAT)
      puts part2_time.format(FORMAT)
    end

    def part1
      puts "Part 1: hasn't been completed yet."
    end

    def part2
      puts "Part 2: hasn't been completed yet."
    end

    private

    def read_input_file
      ::File.read(input_file).chomp
    end

    def input_file
      file = "#{class_snake_case}.txt"
      ::File.join(INPUT_DIR, file)
    end

    def class_snake_case
      filename = Object.const_source_location(self.class.to_s)[0]
      ::File.basename(filename).split('.')[0]
    end
  end
end
