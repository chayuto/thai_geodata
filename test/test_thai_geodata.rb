# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/thai_geodata'

class ThaiGeodataTest < Minitest::Test
  def test_provinces_loaded
    assert ThaiGeodata.provinces.any?
  end
end
