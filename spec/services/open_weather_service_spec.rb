require 'rails_helper'

describe OpenWeatherService, :vcr do
  let(:coords) { { lat: 30.26497, lng: -97.746598 } }
  let!(:result) { OpenWeatherService.weather_data(coords) }
  let(:current) { result[:current_weather] }
  let(:hourly) { result[:hourly_weather] }
  let(:daily) { result[:daily_weather] }
  let!(:datetime_regex) { /\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\s[+-]\d{4}/ }
  let!(:date_regex) { /\d{4}-\d{2}-\d{2}/ }
  let!(:time_regex) { /\d{2}:\d{2}:\d{2}/ }

  describe 'filtering data' do
    it 'has the correct root keys' do
      expect(result).to have_key :current_weather
      expect(result).to have_key :hourly_weather
      expect(result).to have_key :daily_weather

      expect(result).to_not have_key :minutely
      expect(result).to_not have_key :alerts
    end

    it 'has the correct hourly, daily sizes' do
      expect(result[:hourly_weather].size).to eq 8
      expect(result[:daily_weather].size).to eq 5
    end

    it 'filters the current weather' do
      expected_keys = %i[
        datetime sunrise sunset temp feels_like humidity uvi visibility conditions icon
      ]

      expect(current.keys).to eq(expected_keys)
    end

    it 'filters hourly weather' do
      expected_keys = %i[time temp conditions icon]

      hourly.each do |hour|
        expect(hour.keys).to eq(expected_keys)
      end
    end

    it 'filters daily weather' do
      expected_keys = %i[
        date sunrise sunset min_temp max_temp conditions icon
      ]

      daily.each do |day|
        expect(day.keys).to eq(expected_keys)
      end
    end
  end

  describe 'time formatting' do
    it 'formats the times for current weather' do
      expect(current[:datetime]).to match(datetime_regex)
      expect(current[:sunrise]).to match(datetime_regex)
      expect(current[:sunrise]).to match(datetime_regex)
    end

    it 'formats the times for hourly weather' do
      expect(hourly.first[:time]).to match(time_regex)
    end

    it 'formats the times for daily weather' do
      expect(daily.first[:date]).to match(date_regex)
      expect(daily.first[:sunrise]).to match(datetime_regex)
      expect(daily.first[:sunrise]).to match(datetime_regex)
    end
  end
end
