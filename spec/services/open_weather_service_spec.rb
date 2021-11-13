require 'rails_helper'

describe OpenWeatherService, :vcr do
  let(:coords) { { lat: 30.26497, lon: -97.746598 } }
  let!(:result) { OpenWeatherService.weather_data(coords) }
  let(:current) { result[:current] }
  let(:hourly) { result[:hourly] }
  let(:daily) { result[:daily] }

  describe 'filtering data' do
    it 'has the correct root keys' do
      expect(result).to have_key :current
      expect(result).to have_key :hourly
      expect(result).to have_key :daily

      expect(result).to_not have_key :minutely
      expect(result).to_not have_key :alerts
    end

    it 'has the correct hourly, daily sizes' do
      expect(result[:hourly].size).to eq 8
      expect(result[:daily].size).to eq 5
    end

    it 'filters the current weather' do
      expected_keys = %i[
        dt sunrise sunset temp feels_like humidity uvi visibility description icon
      ]

      expect(current.keys).to eq(expected_keys)
    end

    it 'filters hourly weather' do
      expected_keys = %i[dt temp description icon]

      hourly.each do |hour|
        expect(hour.keys).to eq(expected_keys)
      end
    end

    it 'filters daily weather' do
      expected_keys = %i[
        dt sunrise sunset min_temp max_temp description icon
      ]

      daily.each do |day|
        expect(day.keys).to eq(expected_keys)
      end
    end
  end
end
