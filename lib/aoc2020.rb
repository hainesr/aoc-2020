# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'rubygems'
require 'bundler/setup'

require 'aoc2020/day'

module AOC2020
  INPUT_DIR = ::File.expand_path('../etc', __dir__)

  DAY_MAP = [
    nil, # There is no day zero!
    'report_repair',
    'password_philosophy',
    'toboggan_trajectory',
    'passport_processing',
    'binary_boarding',
    'custom_customs',
    'handy_haversacks',
    'handheld_halting',
    'encoding_error',
    'adapter_array',
    'seating_system',
    'rain_risk',
    'shuttle_search',
    'docking_data',
    'rambunctious_recitation',
    'ticket_translation',
    'conway_cubes',
    'operation_order',
    'monster_messages',
    nil,
    'allergen_assessment'
  ].freeze

  def self.class_from_day(day)
    class_name = day.split('_').map(&:capitalize).join
    class_path = "AOC2020::#{class_name}"
    class_path.split('::').reduce(Object) { |o, c| o.const_get c }
  end
end
