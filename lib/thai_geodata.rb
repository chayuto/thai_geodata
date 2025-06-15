# frozen_string_literal: true

require 'json'
require_relative 'thai_geodata/version'

# ThaiGeodata provides in-memory lookup of Thailand’s provinces, districts,
# subdistricts, and combined geography records (with postal codes) from static JSON data.
module ThaiGeodata
  DATA_PATH = File.join(__dir__, 'thai_geodata', 'data')

  class << self
    # Raw data loaders
    def provinces
      @provinces ||= load_json('provinces.json')
    end

    def districts
      @districts ||= load_json('districts.json')
    end

    def subdistricts
      @subdistricts ||= load_json('subdistricts.json')
    end

    def geography
      @geography ||= load_json('geography.json')
    end

    # Lookup helpers

    # Find a province by code (Integer or String), or Thai/English name
    def find_province(code_or_name)
      provinces.find do |p|
        match_code_or_name?(p, 'provinceCode', 'provinceNameTh', 'provinceNameEn', code_or_name)
      end
    end

    # Find a district by code (Integer or String), or Thai/English name
    def find_district(code_or_name)
      districts.find do |d|
        match_code_or_name?(d, 'districtCode', 'districtNameTh', 'districtNameEn', code_or_name)
      end
    end

    # Find a subdistrict by code (Integer or String), or Thai/English name
    def find_subdistrict(code_or_name)
      subdistricts.find do |s|
        match_code_or_name?(s, 'subdistrictCode', 'subdistrictNameTh', 'subdistrictNameEn', code_or_name)
      end
    end

    # List all districts for a given province (code or name)
    def districts_for_province(province_code_or_name)
      prov = find_province(province_code_or_name)
      return [] unless prov

      districts.select { |d| d['provinceCode'] == prov['provinceCode'] }
    end

    # List all subdistricts for a given district (code or name)
    def subdistricts_for_district(district_code_or_name)
      dist = find_district(district_code_or_name)
      return [] unless dist

      subdistricts.select { |s| s['districtCode'] == dist['districtCode'] }
    end

    # Get the postal code for a given subdistrict (code or name)
    def postal_code_for_subdistrict(code_or_name)
      sub = find_subdistrict(code_or_name)
      sub ? sub['postalCode'] : nil
    end

    # Get a full path (province, district, subdistrict) for a subdistrict
    def location_path_for_subdistrict(code_or_name)
      sub = find_subdistrict(code_or_name)
      return nil unless sub

      dist = find_district(sub['districtCode'])
      prov = find_province(sub['provinceCode'])

      {
        province: prov ? prov['provinceNameTh'] : nil,
        district: dist ? dist['districtNameTh'] : nil,
        subdistrict: sub['subdistrictNameTh']
      }
    end

    private

    # Load JSON file from DATA_PATH
    def load_json(filename)
      path = File.join(DATA_PATH, filename)
      JSON.parse(File.read(path))
    end

    # Helper to match by numeric code or localized/English names
    def match_code_or_name?(hash, code_key, th_key, en_key, code_or_name)
      if code_or_name.to_s =~ /^\d+$/
        hash[code_key] == code_or_name.to_i
      else
        hash[th_key] == code_or_name || hash[en_key].casecmp(code_or_name.to_s).zero?
      end
    end
    private :match_code_or_name?
  end
end
