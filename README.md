# ThaiGeodata

A lightweight Ruby gem providing Thailand’s official administrative geography data (provinces, districts, subdistricts) and postal codes in a Ruby-friendly API. All data is sourced from the [Thailand Geography JSON](https://github.com/thailand-geography-data/thailand-geography-json) project under the MIT license.

## Features

* 🔍 Fast lookups of provinces, districts, subdistricts, and postal codes
* 🇹🇭 Full Thai & English names
* 📦 Zero external dependencies (only stdlib JSON)
* 🛠 Lazy–loaded and cached in memory

## Installation

Add this line to your application’s `Gemfile`:

```ruby
gem "thai_geodata"
```

Then execute:

```bash
bundle install
```

Or install directly:

```bash
gem install thai_geodata
```

## Usage

```ruby
require "thai_geodata"

# List all provinces
ThaiGeodata.provinces.each do |prov|
  puts "#{prov["provinceCode"]}: #{prov["provinceNameTh"]} (#{prov["provinceNameEn"]})"
end
# => 10: กรุงเทพมหานคร (Bangkok)
#    50: เชียงใหม่ (Chiang Mai)
#    …

# Find a specific province by Thai or English name
tg = ThaiGeodata.provinces.find { |p|
  p["provinceNameTh"] == "เชียงใหม่" || p["provinceNameEn"].casecmp("Chiang Mai").zero?
}
puts tg["provinceCode"]  # => 50

# Get all districts in a given province
districts_in_cm = ThaiGeodata.districts.select { |d|
  d["provinceCode"] == tg["provinceCode"]
}
puts districts_in_cm.map { |d| d["districtNameTh"] }.join(", ")
# => เมืองเชียงใหม่, แม่ริม, สารภี, …

# List all subdistricts in a given district code
subdistricts_in_district = ThaiGeodata.subdistricts.select { |s|
  s["districtCode"] == districts_in_cm.first["districtCode"]
}
puts subdistricts_in_district.map { |s| s["subdistrictNameTh"] }.join(", ")
# => พร้าว, ท่าตอน, …
```

## API Reference

* `ThaiGeodata.provinces` → Array of province hashes
* `ThaiGeodata.districts` → Array of district hashes
* `ThaiGeodata.subdistricts` → Array of subdistrict hashes

*All methods memoize their data on first call.*

## Data Source & Attribution

Geographical data licensed under MIT and maintained by the [Thailand Geography JSON](https://github.com/thailand-geography-data/thailand-geography-json) project.

> **License**: MIT — see [LICENSE.txt](LICENSE.txt) for full text.

## Contributing

1. Fork the repo
2. Create or update JSON files under `lib/thai_geodata/data/`
3. Write tests in `test/` and ensure `rake test` passes
4. Submit a PR with a clear description of changes

Please follow the existing code style and include tests for any new features or bugfixes.

## License

© 2025 Chayut Orapinpatipat
Released under the MIT License. See [LICENSE.txt](LICENSE.txt) for details.
