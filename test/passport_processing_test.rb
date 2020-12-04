# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/passport_processing'

class AOC2020::PassportProcessingTest < MiniTest::Test
  PASSPORTS = <<~EOPASS
    ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    byr:1937 iyr:2017 cid:147 hgt:183cm

    iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
    hcl:#cfa07d byr:1929

    hcl:#ae17e1 iyr:2013
    eyr:2024
    ecl:brn pid:760753108 byr:1931
    hgt:179cm

    hcl:#cfa07d eyr:2025 pid:166559648
    iyr:2011 ecl:brn hgt:59in
  EOPASS

  def setup
    @pp = AOC2020::PassportProcessing.new
  end

  def test_parse
    passports = @pp.parse(PASSPORTS)
    assert_equal(4, passports.length)
    assert_equal(8, passports[0].length)
    assert(passports[0].key?('cid'))
    refute(passports[2].key?('cid'))
  end

  def test_valid?
    passports = @pp.parse(PASSPORTS)
    assert(@pp.valid?(passports[0]))
    refute(@pp.valid?(passports[1]))
    assert(@pp.valid?(passports[2]))
    refute(@pp.valid?(passports[3]))
  end
end
