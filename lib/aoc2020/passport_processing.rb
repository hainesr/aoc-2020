# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'aoc2020'

module AOC2020
  class PassportProcessing < Day
    def setup
      @input = parse(read_input_file)
    end

    def part1
      valid = @input.count { |passport| valid?(passport) }
      puts "Part 1: #{valid}"
    end

    def part2
      valid = @input.count { |passport| fully_valid?(passport) }
      puts "Part 2: #{valid}"
    end

    def valid?(passport)
      return true if passport.length == 8
      return true if passport.length == 7 && !passport.key?('cid')

      false
    end

    def fully_valid?(passport)
      return false unless valid?(passport)

      passport.map { |key, value| VALIDATIONS[key].call(value) }.all?
    end

    def parse(input)
      passports = input.split("\n\n").map(&:split)
      passports.map do |fields|
        fields.map { |f| f.split(':') }.to_h
      end
    end

    VALIDATIONS = {
      'byr' => lambda { |byr|
        (1920..2002).cover?(byr.to_i)
      },

      'iyr' => lambda { |iyr|
        (2010..2020).cover?(iyr.to_i)
      },

      'eyr' => lambda { |eyr|
        (2020..2030).cover?(eyr.to_i)
      },

      'hgt' => lambda { |hgt|
        height = hgt.to_i

        if hgt.end_with?('cm')
          (150..193).cover?(height)
        elsif hgt.end_with?('in')
          (59..76).cover?(height)
        else
          false
        end
      },

      'hcl' => lambda { |hcl|
        /^#[[:xdigit:]]{6}$/.match?(hcl)
      },

      'ecl' => lambda { |ecl|
        %w[amb blu brn gry grn hzl oth].include?(ecl)
      },

      'pid' => lambda { |pid|
        /^[[:digit:]]{9}$/.match?(pid)
      },

      'cid' => lambda { |_|
        true
      }
    }.freeze
  end
end
