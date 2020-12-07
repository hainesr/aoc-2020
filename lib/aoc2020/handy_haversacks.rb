# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class HandyHaversacks < Day
    def setup
      @input = parse(read_input_file)
    end

    def part1
      puts "Part 1: #{count_contains(:shiny_gold)}"
    end

    def part2
      puts "Part 2: #{count_in(:shiny_gold)}"
    end

    def count_contains(bag, rules = @input)
      rules.keys.map { |rule| contains?(rule, bag, rules) }.count { _1 }
    end

    def count_in(bag, rules = @input)
      count_all(bag, rules) - 1
    end

    def count_all(bag, rules = @input)
      return 1 if rules[bag].empty?

      children = 0
      rules[bag].each do |k, v|
        v.times do
          children += count_all(k, rules)
        end
      end

      1 + children
    end

    def contains?(outer, inner, rules = @input)
      return true if rules[outer].key?(inner)

      rules[outer].map { |key, _| contains?(key, inner, rules) }.any?
    end

    def parse(input)
      input.split("\n").each_with_object({}) do |line, rules|
        line = line.split('contain')
        rule_name = parse_bag(line[0])
        bags = line[1].split(',').map(&:strip)
        rules[rule_name] = bags.each_with_object({}) do |bag, rule|
          num = bag.to_i
          rule[parse_bag(bag.split[1..])] = num unless num.zero?
        end
      end
    end

    def parse_bag(bag)
      bag = bag.split unless bag.is_a?(Array)
      "#{bag[0]}_#{bag[1]}".to_sym
    end
  end
end
