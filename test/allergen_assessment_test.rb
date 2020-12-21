# frozen_string_literal: true

# Advent of Code 2020
#
# Robert Haines
#
# Public Domain

require 'test_helper'
require 'aoc2020/allergen_assessment'

class AOC2020::AllergenAssessmentTest < MiniTest::Test
  INPUT = <<~EOINPUT
    mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
    trh fvjkl sbzzf mxmxvkd (contains dairy)
    sqjhc fvjkl (contains soy)
    sqjhc mxmxvkd sbzzf (contains fish)
  EOINPUT

  def setup
    @aa = AOC2020::AllergenAssessment.new
  end

  def test_read_foods
    foods = @aa.read_foods(INPUT)
    assert_equal([['soy'], %w[sqjhc fvjkl]], foods[2])
  end

  def test_find_not_allergens
    _, na = @aa.find_not_allergens(@aa.read_foods(INPUT))
    assert_equal(%w[kfcds nhms trh sbzzf], na)
  end

  def test_count_not_allergens
    foods = @aa.read_foods(INPUT)
    _, na = @aa.find_not_allergens(foods)
    assert_equal(
      5, @aa.count_not_allergens(foods, na)
    )
  end

  def test_match_allergens
    foods = @aa.read_foods(INPUT)
    all, = @aa.find_not_allergens(foods)
    assert_equal(
      { 'dairy' => 'mxmxvkd', 'fish' => 'sqjhc', 'soy' => 'fvjkl' },
      @aa.match_allergens(all)
    )
  end
end
