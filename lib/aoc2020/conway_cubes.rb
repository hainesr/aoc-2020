# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class ConwayCubes < Day
    ADJ27 = [-1, 0, 1].product([-1, 0, 1], [-1, 0, 1]).freeze
    ADJ26 = (ADJ27 - [[0, 0, 0]]).freeze

    def setup
      @coords = parse(read_input_file)
    end

    def part1
      puts "Part 1: #{boot(@coords).values.sum}"
    end

    def parse(input)
      coords = {}
      input.split.each_with_index do |line, y|
        line.chars.each_with_index do |cell, x|
          coords[[x, y, 0]] = 1 if cell == '#'
        end
      end
      coords
    end

    def boot(coords, cycles = 6)
      cycles.times do
        n_coords = {}

        coords.each do |(cx, cy, cz), _|
          ADJ27.each do |(nx, ny, nz)|
            coord = [x = cx + nx, y = cy + ny, z = cz + nz].freeze
            next if n_coords.key?(coord)

            nbours = ADJ26.sum do |(dx, dy, dz)|
              coords.fetch([x + dx, y + dy, z + dz], 0)
            end

            n_coords[coord] = if nbours == 3
                                1
                              else
                                coords[coord] == 1 && nbours == 2 ? 1 : 0
                              end
          end
        end

        coords = n_coords.select { |_, v| v == 1 }
      end

      coords
    end
  end
end
