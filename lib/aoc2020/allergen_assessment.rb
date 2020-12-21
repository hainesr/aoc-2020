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
      @allergen_candidates, @not_allergens = find_not_allergens(@input)
    end

    def part1
      count = count_not_allergens(@input, @not_allergens)
      puts "Part 1: #{count}"
    end

    def part2
      allergens = match_allergens(@allergen_candidates)
      list = allergens.sort_by(&:first).map(&:last).join(',')
      puts "Part 2: #{list}"
    end

    def match_allergens(allergens, acc = {})
      return acc if allergens.empty?

      all, ing = allergens.filter { |_, v| v.length == 1 }.to_a.flatten
      acc[all] = ing
      a = {}
      allergens.each do |k, v|
        next if k == all

        a[k] = v - [ing]
      end

      match_allergens(a, acc)
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

      [allergens, ingredients - allergens.sum([], &:last)]
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
