# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class MonsterMessages < Day
    def setup
      @rules, @messages = parse(read_input_file)
    end

    def part1
      zero = expand_rule(0)
      num = @messages.map { |m| match_rule?(m, zero) }.count(true)
      puts "Part 1: #{num}"
    end

    def match_rule?(message, rule)
      match = /^#{rule}$/.match(message)
      return false if match.nil?

      match.to_a.each { |m| return true if m == message }
      false
    end

    def expand_rule(num, rules = @rules, acc = '')
      rule = rules[num]

      case rule
      when /a|b/
        acc + rule
      when Array
        if rule[0].is_a?(Array)
          left = rule[0].map { |o| expand_rule(o, rules, acc) }.join
          right = rule[1].map { |o| expand_rule(o, rules, acc) }.join
          "(#{left}|#{right})"
        else
          rule.map { |r| expand_rule(r, rules, acc) }.join
        end
      end
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
