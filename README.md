# Worry Free Weather

A back-end SOA application providing up-to-date weather forcasts taken from Open Weather
and providing travel time and weather on arrival for road trips.

# Technologies

### Primary

- Ruby 2.7.2
- Rails 5.2.6
- PostgreSQL
- RSpec

### Secondary

- Bcrypt
- Faraday
- JSONAPI-serializers
- SimpleCov
- Webmock + VCR

# Set Up

1) `bundle install`
2) `rails db:{create,migrate,seed}`

# Testing

### Overview

- TDD process utilizing RSpec
- Coverage monitored by SimpleCov

### Execute Test Suite

1) `bundle exec rspec`
