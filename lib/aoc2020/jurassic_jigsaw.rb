# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class JurassicJigsaw < Day
    def setup
      @image = Image.new(read_input_file)
    end

    def part1
      corners = @image.corners
      puts "Part 1: #{corners.map(&:id).reduce(:*)}"
    end

    class Tile
      attr_reader :borders, :id, :neighbours, :uniq_borders

      def initialize(tile)
        id_text, *@img = tile.split("\n")
        @id = id_text.split.last.chomp(':').to_i
        @borders = make_borders(@img)
        @uniq_borders = []
        @neighbours = {}
      end

      private

      def make_borders(img)
        %i[top bottom left right].to_h { |i| [i, make_border(img, i)] }
      end

      def make_border(img, border)
        case border
        when :top
          img[0]
        when :bottom
          img[-1]
        when :left
          img.map { |i| i[0] }.join
        when :right
          img.map { |i| i[-1] }.join
        end
      end
    end

    class Image
      attr_reader :tiles

      def initialize(input)
        matches = {}

        @tiles = input.split("\n\n").to_h do |tile|
          t = Tile.new(tile)

          t.borders.each do |border, str|
            min = [bitmap(str), bitmap(str.reverse)].min

            case matches[min]
            when nil
              matches[min] = [border, t]
            when Array
              other_b, other_t = t.neighbours[border] = matches[min]
              other_t.neighbours[other_b] = [border, t]
              matches[min] = :done
            end
          end

          [t.id, t]
        end

        matches.each_value do |border, tile|
          tile.uniq_borders << border unless tile.nil?
        end
      end

      def corners
        @tiles.each_value.select { |tile| tile.uniq_borders.length == 2 }
      end

      private

      def bitmap(str)
        str.each_char.with_index.sum do |c, i|
          (c == '#' ? 1 : 0) << i
        end
      end
    end
  end
end
