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

    def part2
      tickets = valid_tickets
      id_map = id_fields(tickets, @fields)

      total = id_map.keys.reduce(1) do |acc, k|
        next acc unless k.start_with?('departure')

        acc * @my_ticket[id_map[k]]
      end

      puts "Part 2: #{total}"
    end

    def error_rate(tickets = @tickets, fields = @field_values)
      tickets.map do |ticket|
        ticket.difference(fields).sum
      end.sum
    end

    def valid_tickets(tickets = @tickets, fields = @field_values)
      tickets.select do |ticket|
        ticket.difference(fields).empty?
      end
    end

    def id_fields(tickets, fields)
      fields = fields.dup
      ticket_values = tickets.transpose
      id_lookup = {}

      fields.length.times do
        ticket_values.each_with_index do |values, i|
          next if id_lookup.values.include?(i)

          match = matching_fields_for_values(values, fields)
          if match.length == 1
            fields.delete(match[0])
            id_lookup[match[0]] = i
          end
        end

        break if fields.empty?
      end

      id_lookup
    end

    def matching_fields_for_values(values, fields)
      matches = []

      fields.each do |k, v|
        match = values.each do |val|
          break false unless v.include?(val)
        end
        matches << k if match
        break if matches.length > 1
      end

      matches
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
