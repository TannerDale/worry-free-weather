require 'rails_helper'

describe ForecastSerializer, :vcr do
  let(:coords) { { lat: 30.26497, lng: -97.746598 } }
  let!(:response) { OpenWeatherService.weather_data(coords) }
  let(:serialized) { ForecastSerializer.serialize(response) }
  let(:result) { JSON.parse(serialized, symbolize_names: true) }
  let(:data) { result[:data] }
  let(:attributes) { data[:attributes] }

  it 'has the root keys' do
    expect(result).to have_key :data

    expect(data).to have_key :id
    expect(data[:id]).to be nil

    expect(data).to have_key :type
    expect(data[:type]).to eq('forecast')

    expect(data).to have_key :attributes
    expect(data[:attributes]).to_not be_empty
  end

  it 'has the correct attribute data' do
    expect(attributes).to have_key :current_weather
    expect(attributes[:current_weather]).to_not be_empty

    expect(attributes).to have_key :hourly_weather
    expect(attributes[:hourly_weather]).to be_an Array
    expect(attributes[:hourly_weather].size).to eq 8

    expect(attributes).to have_key :daily_weather
    expect(attributes[:daily_weather]).to be_an Array
    expect(attributes[:daily_weather].size).to eq 5
  end
end
