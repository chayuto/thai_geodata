# frozen_string_literal: true

require 'json'
require_relative 'thai_geodata/version'

# ThaiGeodata provides in-memory lookup of Thailand’s provinces, districts
# and subdistricts (with postal codes) from static JSON data.
module ThaiGeodata
  DATA_PATH = File.join(__dir__, 'thai_geodata', 'data')

  def self.provinces
    @provinces ||= load_json('provinces.json')
  end

  def self.districts
    @districts ||= load_json('districts.json')
  end

  def self.subdistricts
    @subdistricts ||= load_json('subdistricts.json')
  end

  def self.load_json(file)
    JSON.parse(File.read(File.join(DATA_PATH, file)))
  end
end
