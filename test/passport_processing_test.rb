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

  INVALID = <<~EOINVALID
    eyr:1972 cid:100
    hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

    iyr:2019
    hcl:#602927 eyr:1967 hgt:170cm
    ecl:grn pid:012533040 byr:1946

    hcl:dab227 iyr:2012
    ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

    hgt:59cm ecl:zzz
    eyr:2038 hcl:74454a iyr:2023
    pid:3556412378 byr:2007
  EOINVALID

  VALID = <<~EOVALID
    pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
    hcl:#623a2f

    eyr:2029 ecl:blu cid:129 byr:1989
    iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

    hcl:#888785
    hgt:164cm byr:2001 iyr:2015 cid:88
    pid:545766238 ecl:hzl
    eyr:2022

    iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
  EOVALID

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

  def test_validations
    v = @pp.validations

    assert(v['byr'].call('2002'))
    refute(v['byr'].call('2003'))

    assert(v['hgt'].call('60in'))
    assert(v['hgt'].call('190cm'))
    refute(v['hgt'].call('190in'))
    refute(v['hgt'].call('190'))

    assert(v['hcl'].call('#123abc'))
    refute(v['hcl'].call('#123abz'))
    refute(v['hcl'].call('123abc'))
    refute(v['hcl'].call('#123abcd'))

    assert(v['ecl'].call('brn'))
    refute(v['ecl'].call('wat'))

    assert(v['pid'].call('000000001'))
    refute(v['pid'].call('0123456789'))

    assert(v['cid'].call('000000001'))
    assert(v['cid'].call(''))
  end

  def test_fully_valid?
    @pp.parse(INVALID).each { |passport| refute(@pp.fully_valid?(passport)) }
    @pp.parse(VALID).each { |passport| assert(@pp.fully_valid?(passport)) }
  end
end
