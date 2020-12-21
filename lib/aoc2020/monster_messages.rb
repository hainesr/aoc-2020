# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class MonsterMessages < Day
    def initialize
      super
      @rules_cache = {}
    end

    def setup
      @rules, @messages = parse(read_input_file)
    end

    def part1
      zero = expand_rule(0)
      num = @messages.map { |m| match_rule?(m, zero) }.count(true)
      puts "Part 1: #{num}"
    end

    def part2
      seed_cache
      zero = expand_rule(0)
      num = @messages.map { |m| match_rule?(m, zero) }.count(true)
      puts "Part 2: #{num}"
    end

    def match_rule?(message, rule)
      match = /^#{rule}$/.match(message)
      return false if match.nil?

      match.to_a.each { |m| return true if m == message }
      false
    end

    def expand_rule(num, rules = @rules, acc = '')
      return @rules_cache[num] if @rules_cache.include?(num)

      rule = rules[num]
      exp = case rule
            when /a|b/
              acc + rule
            when Array
              if rule[0].is_a?(Array)
                left = rule[0].map { |o| expand_rule(o, rules, acc) }.join
                right = rule[1].map { |o| expand_rule(o, rules, acc) }.join
                "(?:#{left}|#{right})"
              else
                "(?:#{rule.map { |r| expand_rule(r, rules, acc) }.join})"
              end
            end

      @rules_cache[num] = exp
      exp
    end

    def seed_cache(rules = @rules)
      # Empty cache.
      @rules_cache = {}

      # Expand the rules "below" the edit point.
      rule42 = expand_rule(42, rules)
      rule31 = expand_rule(31, rules)

      # Re-initialise cache with just the edited rules.
      # Take advantage of recursive matching (\g<1>).
      @rules_cache = {
        8 => "(?:#{rule42})+",
        11 => "(#{rule42}(?:\\g<1>)*#{rule31})"
      }
    end

    def parse(input)
      rules = {}
      messages = []

      input.split("\n").each do |line|
        if line.include?(':')
          k, v = parse_rule(line)
          rules[k] = v
        else
          messages << line unless line.empty?
        end
      end

      [rules, messages]
    end

    def parse_rule(line)
      k, v = line.split(':')
      rule = if v.include?('a')
               'a'
             elsif v.include?('b')
               'b'
             elsif v.include?('|')
               v.split('|').map { |o| o.split.map(&:to_i) }
             else
               v.split.map(&:to_i)
             end

      [k.to_i, rule]
    end
  end
end
