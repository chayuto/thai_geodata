# ThaiGeodata

A lightweight Ruby gem providing Thailand’s official administrative geography data (provinces, districts, subdistricts) and postal codes in a Ruby-friendly API.

ไลบรารี Ruby ขนาดเล็กที่ให้ข้อมูลภูมิศาสตร์ของประเทศไทย (จังหวัด, อำเภอ, ตำบล) พร้อมรหัสไปรษณีย์ ผ่าน API ที่ใช้งานง่าย


## Features

- Fast lookups of provinces, districts, subdistricts, and postal codes
- Dual-language (Thai & English) support for data values
- Zero external dependencies (only stdlib JSON)
- Lazy–loaded and cached in memory

## Installation

Add to your application’s `Gemfile`:
```ruby
gem "thai_geodata"
```
Then run:
```bash
bundle install
```
Or install directly:
```bash
gem install thai_geodata
```

## Usage / การใช้งาน

```ruby
require "thai_geodata"
```

### List all provinces / แสดงรายชื่อจังหวัดทั้งหมด
```ruby
ThaiGeodata.provinces.each do |prov|
  puts "#{prov['provinceCode']}: #{prov['provinceNameTh']} (#{prov['provinceNameEn']})"
end
# => 10: กรุงเทพมหานคร (Bangkok)
#    50: เชียงใหม่ (Chiang Mai)
```

### Find by code or name / ค้นหาจังหวัดโดยรหัสหรือชื่อ
```ruby
# English or Thai name
prov = ThaiGeodata.find_province("Chiang Mai")
puts prov['provinceCode']  # => 50

# Thai name
prov_th = ThaiGeodata.find_province(10)
puts prov_th['provinceNameTh']  # => "กรุงเทพมหานคร"
```

### Districts for a province / อำเภอทั้งหมดของจังหวัด
```ruby
dists = ThaiGeodata.districts_for_province(10)
puts dists.map { |d| d['districtNameTh'] }.join(", ")
# => พระนคร, ดุสิต, …
```

### Subdistricts for a district / ตำบลทั้งหมดของอำเภอ
```ruby
subs = ThaiGeodata.subdistricts_for_district("Phra Nakhon")
puts subs.map { |s| s['subdistrictNameTh'] }
# => พระบรมมหาราชวัง, วังบูรพาภิรมย์, …
```

### Postal code lookup / ค้นหารหัสไปรษณีย์
```ruby
pc = ThaiGeodata.postal_code_for_subdistrict("พระบรมมหาราชวัง")
puts pc  # => 10200
```

### Combined geography records / ข้อมูลผสมจังหวัด-อำเภอ-ตำบล-รหัสไปรษณีย์
```ruby
results = ThaiGeodata.geography.select { |row| row['postalCode'] == 10200 }
results.each do |row|
  puts "#{row['provinceNameTh']} > #{row['districtNameTh']} > #{row['subdistrictNameTh']} (#{row['postalCode']})"
end
# => กรุงเทพมหานคร > พระนคร > พระบรมมหาราชวัง (10200)
```

## API Reference

- `ThaiGeodata.provinces` → Array of province hashes
- `ThaiGeodata.districts` → Array of district hashes
- `ThaiGeodata.subdistricts` → Array of subdistrict hashes
- `ThaiGeodata.geography` → Combined array of all records
- `find_province(code_or_name)` → Single province hash or `nil`
- `find_district(code_or_name)` → Single district hash or `nil`
- `find_subdistrict(code_or_name)` → Single subdistrict hash or `nil`
- `districts_for_province(code_or_name)` → Array of districts
- `subdistricts_for_district(code_or_name)` → Array of subdistricts
- `postal_code_for_subdistrict(code_or_name)` → Integer or `nil`
- `location_path_for_subdistrict(code_or_name)` → `{province:, district:, subdistrict:}` or `nil`

_All methods memoize their data on first call._

## Data Source & Attribution

Geographical data licensed under MIT and maintained by the [Thailand Geography JSON](https://github.com/thailand-geography-data/thailand-geography-json) project.

## Contributing

1. Fork the repo
2. Create or update JSON files under `lib/thai_geodata/data/`
3. Write tests in `test/` and ensure `rake test` passes
4. Submit a PR with a clear description of changes

## License

© 2025 Chayut Orapinpatipat
Released under the MIT License. See [LICENSE.txt](LICENSE.txt) for details.
