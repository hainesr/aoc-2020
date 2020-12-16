# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class TicketTranslation < Day
    def setup
      @fields, @my_ticket, @tickets = parse_input(read_input_file)
      @field_values = @fields.values.flatten.compact
    end

    def part1
      puts "Part 1: #{error_rate}"
    end

    def error_rate(tickets = @tickets, fields = @field_values)
      tickets.map do |ticket|
        ticket.difference(fields).sum
      end.sum
    end

    def parse_input(input)
      type = :field
      fields = {}
      my_ticket = []
      tickets = []
      input.split("\n").each do |line|
        line = line.chomp
        next if line.empty?

        case type
        when :field
          if line == 'your ticket:'
            type = :my_ticket
            next
          end

          key, value = parse_field(line)
          fields[key] = value
        when :my_ticket
          if line == 'nearby tickets:'
            type = :tickets
            next
          end

          my_ticket = line.split(',').map(&:to_i)
        else
          tickets << line.split(',').map(&:to_i)
        end
      end

      [fields, my_ticket, tickets]
    end

    def parse_field(input)
      k, v = input.split(': ')
      key = k.tr(' ', '_').to_sym
      value = v.split(' or ').map do |range|
        f, l = range.split('-').map(&:to_i)
        (f..l)
      end.map(&:to_a).flatten

      [key, value]
    end
  end
end
