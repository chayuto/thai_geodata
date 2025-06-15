# frozen_string_literal: true

# thai_geodata.gemspec

# Load the version constant so s.version = ThaiGeodata::VERSION works
require_relative 'lib/thai_geodata/version'

Gem::Specification.new do |s|
  s.name        = 'thai_geodata'
  s.version     = ThaiGeodata::VERSION
  s.summary     = 'Thailand geography data: provinces, districts, subdistricts, postal codes'
  s.description = 'A Ruby gem wrapping the MIT-licensed Thailand Geography JSON dataset, with lookup helpers.'
  s.authors     = ['Your Name']
  s.email       = ['you@example.com']
  s.files       = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }
  s.homepage    = 'https://github.com/yourusername/thai_geodata'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.7'
  s.add_development_dependency 'minitest', '~> 5.0'
end
