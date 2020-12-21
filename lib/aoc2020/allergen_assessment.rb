# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class AllergenAssessment < Day
    def setup
      @input = read_foods(read_input_file)
    end

    def part1
      na = find_not_allergens(@input)
      count = count_not_allergens(@input, na)
      puts "Part 1: #{count}"
    end

    def count_not_allergens(foods, not_allergens)
      foods.sum do |_, ings|
        ings.count { |ing| not_allergens.include?(ing) }
      end
    end

    def find_not_allergens(foods)
      ingredients = foods.map(&:last).flatten.uniq
      allergens = foods.map(&:first).flatten.uniq.to_h { |a| [a, ingredients] }

      foods.each do |alls, ings|
        alls.each do |allergen|
          allergens[allergen] &= ings
        end
      end

      ingredients - allergens.sum([], &:last)
    end

    def read_foods(input)
      foods = []

      input.split("\n").each do |line|
        ings, allers = line.chomp(')').split(' (contains ')
        foods << [allers.split(', '), ings.split]
      end

      foods
    end
  end
end
