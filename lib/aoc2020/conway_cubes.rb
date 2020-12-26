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
    ADJ81 = [-1, 0, 1].product([-1, 0, 1], [-1, 0, 1], [-1, 0, 1]).freeze
    ADJ80 = (ADJ81 - [[0, 0, 0, 0]]).freeze

    def setup
      input = read_input_file
      @coords = parse(input)
      @coords4 = parse(input, w: true)
    end

    def part1
      puts "Part 1: #{boot(@coords).values.sum}"
    end

    def part2
      puts "Part 2: #{boot(@coords4).values.sum}"
    end

    def parse(input, w: false)
      coords = {}
      input.split.each_with_index do |line, y|
        line.chars.each_with_index do |cell, x|
          key = w ? [x, y, 0, 0] : [x, y, 0]
          coords[key] = 1 if cell == '#'
        end
      end
      coords
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/PerceivedComplexity
    def boot(coords, cycles = 6)
      if coords.keys.first.length == 4
        time = true
        adj = ADJ80
        adjs = ADJ81
      else
        time = false
        adj = ADJ26
        adjs = ADJ27
      end

      cycles.times do
        n_coords = {}

        coords.each do |(cx, cy, cz, cw), _|
          adjs.each do |(nx, ny, nz, nw)|
            coord = [x = cx + nx, y = cy + ny, z = cz + nz]
            coord += [w = cw + nw] if time
            next if n_coords.key?(coord)

            nbours = adj.sum do |(dx, dy, dz, dw)|
              c = [x + dx, y + dy, z + dz]
              c += [w + dw] if time
              coords.fetch(c, 0)
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
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/AbcSize
  end
end
