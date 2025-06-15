# frozen_string_literal: true

# thai_geodata.gemspec

# Load the version constant so s.version = ThaiGeodata::VERSION works
require_relative 'lib/thai_geodata/version'

Gem::Specification.new do |s|
  s.name        = 'thai_geodata'
  s.version     = ThaiGeodata::VERSION
  s.summary     = 'Thailand geography data: provinces, districts, subdistricts, postal codes'
  s.description = 'A Ruby gem wrapping the MIT-licensed Thailand Geography JSON dataset, with lookup helpers.'
  s.authors     = ['Chayut Orapinpatipat']
  s.email       = ['chayut_o@hotmail.com']
  s.files       = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }
  s.homepage    = 'https://github.com/chayuto/thai_geodata'
  s.metadata    ||= {}
  s.metadata['documentation_uri'] = 'https://github.com/chayuto/thai_geodata#readme'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.7'
  s.add_development_dependency 'minitest', '~> 5.0'
end
