# frozen_string_literal: true

require 'minitest/autorun'
require 'thai_geodata'

class ThaiGeodataTest < Minitest::Test
  def test_provinces_loaded
    refute_empty ThaiGeodata.provinces
  end

  def test_find_province_by_code
    bangkok = ThaiGeodata.find_province(10)
    assert_equal 'กรุงเทพมหานคร', bangkok['provinceNameTh']
  end

  def test_find_province_by_name_en
    cm = ThaiGeodata.find_province('Chiang Mai')
    assert_equal 50, cm['provinceCode']
  end

  def test_find_district_by_code
    dist = ThaiGeodata.find_district(1001)
    assert_equal 'พระนคร', dist['districtNameTh']
  end

  def test_find_subdistrict_by_code
    sub = ThaiGeodata.find_subdistrict(100_101)
    assert_equal 'พระบรมมหาราชวัง', sub['subdistrictNameTh']
  end

  def test_districts_for_province
    dists = ThaiGeodata.districts_for_province('Bangkok')
    assert dists.any?
    assert_equal(dists, ThaiGeodata.districts.select { |d| d['provinceCode'] == 10 })
  end

  def test_subdistricts_for_district
    subs = ThaiGeodata.subdistricts_for_district(1001)
    assert subs.any?
    assert_equal(subs, ThaiGeodata.subdistricts.select { |s| s['districtCode'] == 1001 })
  end

  def test_postal_code_for_subdistrict
    assert_equal 10_200, ThaiGeodata.postal_code_for_subdistrict(100_101)
  end

  def test_location_path_for_subdistrict
    path = ThaiGeodata.location_path_for_subdistrict(100_101)
    expected = {
      province: 'กรุงเทพมหานคร',
      district: 'พระนคร',
      subdistrict: 'พระบรมมหาราชวัง'
    }
    assert_equal expected, path
  end

  def test_geography_loaded
    refute_empty ThaiGeodata.geography
    first = ThaiGeodata.geography.first
    assert first.key?('provinceCode')
    assert first.key?('postalCode')
  end
end
