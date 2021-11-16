# Worry Free Weather

A back-end SOA application providing up-to-date weather forcasts
and providing travel time and weather on arrival information for road trips.

# Technologies

### Primary

- Ruby 2.7.2
- Rails 5.2.6
- PostgreSQL
- [RSpec](https://github.com/rspec/rspec-rails)

### Secondary

- [Bcrypt](https://github.com/bcrypt-ruby/bcrypt-ruby)
- [Faraday](https://github.com/lostisland/faraday)
- [JSONAPI-serializers](https://github.com/jsonapi-serializer/jsonapi-serializer)
- [SimpleCov](https://github.com/simplecov-ruby/simplecov)
- [Webmock](https://github.com/bblimke/webmock) + [VCR](https://github.com/vcr/vcr)

# Set Up

1) `bundle install`
2) `rails db:{create,migrate,seed}`

# Testing

### Overview

- TDD process utilizing RSpec
- Coverage details by SimpleCov

### Execute Test Suite

1) `bundle exec rspec`

# Features

### Weather data for a given location

#### Endpoint
- `GET /api/v1/forecast?location={city,state}`

#### Response:
- `status: 200`
```json
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "datetime": "2020-09-30 13:27:03 -0600",
        "temperature": 79.4,
        {etc}
      },
      "daily_weather": [
        {
          "date": "2020-10-01",
          "sunrise": "2020-10-01 06:10:43 -0600",
          {etc}
        },
        {...}
      ],
      "hourly_weather": [
        {
          "time": "14:00:00",
          "conditions": "Pretty chilly, slight chance of rain",
          {etc}
        },
        {...}
      ]
    }
  }
}
```

### Image for a given city

#### Endpoint
- `GET /api/v1/backgrounds?location={city,state}`

#### Response:
- `status: 200`
```json
{
  "data": {
    "id": null,
    "type": "image",
    "attributes": {
      "image_url": "https://image_url.com",
      "author_name": "Tom Jerry"
    }
  }
}
```

### User Registration

#### Endpoint
- `POST /api/v1/users`
- Request Body:
```json
{
  "email": "email@provider.com",
  "password": "supersecretpassword",
  "password_confirmation": "supersecretpassword"
}
```
#### Response:
- `status: 201`
```json
{
  "data": {
    "id": "1",
    "type": "users",
    "attributes": {
      "email": "email@provider.com",
      "api_key": "{key generated on creation}"
    }
  }
}
```

### User Login

#### Endpoint
- `POST /api/v1/users`
- Request Body:
```json
{
  "email": "email@provider.com",
  "password": "supersecretpassword"
}
```
- Response:
- `status: 200`
```json
{
  "data": {
    "id": "1",
    "type": "users",
    "attributes": {
      "email": "email@provider.com",
      "api_key": "SomeRandomKey"
    }
  }
}
```

### Road Trip

#### Endpoint
- `POST /api/v1/road_trip`
- Request Body:
```json
{
  "origin": "Olympia,ws",
  "destination": "",
  "api_key": "{your api key}"
}
```
#### Response:
- `status: 200`
```json
{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "olympia,ws",
      "end_city": "miami,fl",
      "travel_time": "20 hours, 55 minutes",
      "weather_at_eta": {
        "temperature": 52.43,
        "conditions": "overcast clouds"
      }
    }
  }
}
```

# Contributors

- Tanner Dale [GitHub](https://github.com/TannerDale), [LinkedIn](https://www.linkedin.com/in/tannerdale/)

# Acknowledgments

- [Open Weather](https://openweathermap.org/api/one-call-api) for weather data
- [MapQuest](https://developer.mapquest.com/) for coordinate and route data
- [Unsplash](https://unsplash.com/developers) for city background images
