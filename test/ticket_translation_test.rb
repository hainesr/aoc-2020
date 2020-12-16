# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/ticket_translation'

class AOC2020::TicketTranslationTest < MiniTest::Test
  INPUT = <<~EOINPUT
    class: 1-3 or 5-7
    row: 6-11 or 33-44
    seat: 13-40 or 45-50

    your ticket:
    7,1,14

    nearby tickets:
    7,3,47
    40,4,50
    55,2,20
    38,6,12
  EOINPUT

  PARSED = [
    {
      class: [1, 2, 3, 5, 6, 7],
      row: [6, 7, 8, 9, 10, 11, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44],
      seat: [
        13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
        30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 47, 48, 49, 50
      ]
    },
    [7, 1, 14],
    [
      [7, 3, 47],
      [40, 4, 50],
      [55, 2, 20],
      [38, 6, 12]
    ]
  ].freeze

  def setup
    @tt = AOC2020::TicketTranslation.new
  end

  def test_parse_field
    assert_equal(
      [:class, [1, 2, 3, 5, 6, 7]], @tt.parse_field('class: 1-3 or 5-7')
    )
    assert_equal(
      [:your_seat, [13, 14, 20, 21]],
      @tt.parse_field('your seat: 13-14 or 20-21')
    )
  end

  def test_parse_input
    assert_equal(PARSED, @tt.parse_input(INPUT))
  end

  def test_error_rate
    fields, _, tickets = @tt.parse_input(INPUT)
    field_values = fields.values.flatten
    assert_equal(71, @tt.error_rate(tickets, field_values))
  end
end
