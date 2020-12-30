# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class JurassicJigsaw < Day
    OPPOSITE = {
      top: :bottom,
      bottom: :top,
      left: :right,
      right: :left
    }.freeze

    ROTATE = {
      top: :left,
      bottom: :right,
      left: :top,
      right: :bottom
    }.freeze

    def setup
      @image = Image.new(read_input_file)
    end

    def part1
      corners = @image.corners
      puts "Part 1: #{corners.map(&:id).reduce(:*)}"
    end

    class Tile
      attr_reader :borders, :id, :img, :neighbours, :uniq_borders

      def initialize(tile)
        id_text, *@img = tile.split("\n")
        @id = id_text.split.last.chomp(':').to_i
        @borders = make_borders(@img)
        @uniq_borders = []
        @neighbours = {}
      end

      def make_me_top_left!
        return false unless @uniq_borders.length == 2

        new_n = @neighbours.dup
        changed = false

        # Need to flip horizontally?
        if @uniq_borders.include?(:right)
          new_n[:right] = new_n.delete(:left)
          flip_h!
          changed = true
        end

        # Need to flip vertically?
        if @uniq_borders.include?(:bottom)
          new_n[:bottom] = new_n.delete(:top)
          flip_v!
          changed = true
        end

        if changed
          @uniq_borders = %i[top left]
          @neighbours = new_n
          @borders = make_borders(@img)
        end

        true
      end

      # rubocop:disable Metrics/CyclomaticComplexity
      # rubocop:disable Metrics/PerceivedComplexity
      def make_me_match_border!(my_border, target)
        already_matching = @borders.select do |_, v|
          v == target || v.reverse == target
        end
        current = already_matching.keys.first

        img_save = @img

        # Do we need to rotate?
        if current != my_border && current != OPPOSITE[my_border]
          rotate!
          current = ROTATE[current]
        end

        # Do we need to flip?
        if current != my_border
          current == :top || current == :bottom ? flip_v! : flip_h!
          current = OPPOSITE[current]
        end

        # Now we're on the same border but are we reversed?
        if make_border(@img, my_border) != target
          current == :top || current == :bottom ? flip_h! : flip_v!
        end

        @borders = make_borders(@img) if @img != img_save
      end
      # rubocop:enable Metrics/PerceivedComplexity
      # rubocop:enable Metrics/CyclomaticComplexity

      def flip_h!
        @img = @img.map(&:reverse)
      end

      def flip_v!
        @img = @img.reverse
      end

      def rotate!
        @img = @img.map(&:chars).transpose.map(&:join)
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

        @grid = nil
        @image = nil
      end

      def corners
        @tiles.each_value.select { |tile| tile.uniq_borders.length == 2 }
      end

      def image!
        return @image unless @image.nil?

        grid!.map do |row|
          lines = row.map do |tile|
            tile.img[1...-1].map { |l| l[1...-1] }
          end
          lines.transpose.map(&:join).join("\n")
        end.join("\n")
      end

      def grid!(start = corners.first)
        return @grid unless @grid.nil?

        start.make_me_top_left!
        top_row = build_line!(start, :right, :row) do |t|
          t.uniq_borders.length == 2
        end
        width = top_row.length
        # Assume a square image for now, but don't need to.
        left_column = build_line!(start, :bottom, :column, width)

        @grid = left_column[1..].map do |left|
          lefts_left_border = if left.uniq_borders.length > 1
                                candidates = left.uniq_borders.reject do |u|
                                  _, t = left.neighbours[OPPOSITE[u]]
                                  t == left_column[-2]
                                end

                                candidates.first
                              else
                                left.uniq_borders.first
                              end
          build_line!(left, OPPOSITE[lefts_left_border], :row, width)
        end.unshift(top_row) # Put top row back.
      end

      private

      def build_line!(start, prev_border, line, length = nil)
        case line
        when :row
          match_border_current = :left
          match_border_prev = :right
        when :column
          match_border_current = :top
          match_border_prev = :bottom
        end

        line = [start]
        prev = start

        until line.length == length
          current_border, current = prev.neighbours[prev_border]
          current.make_me_match_border!(
            match_border_current, prev.borders[match_border_prev]
          )
          prev_border = OPPOSITE[current_border]
          line << current
          break if block_given? && yield(current)

          prev = current
        end

        line
      end

      def bitmap(str)
        str.each_char.with_index.sum do |c, i|
          (c == '#' ? 1 : 0) << i
        end
      end
    end
  end
end
