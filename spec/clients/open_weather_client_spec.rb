require 'rails_helper'

describe OpenWeatherClient, :vcr do
  let(:coords) { 'lat=30.26497&lon=-97.746598' }
  let(:url) { "/data/2.5/onecall?#{coords}&units=imperial" }

  it 'gets the weather data from Open Weather API' do
    result = OpenWeatherClient.fetch(url)

    expect(result).to be_a Hash

    expect(result[:lat]).to eq(30.265)
    expect(result[:lon]).to eq(-97.7466)

    expect(result).to have_key :current
    expect(result[:current]).to_not be_empty

    expect(result).to have_key :hourly
    expect(result[:hourly]).to_not be_empty

    expect(result).to have_key :daily
    expect(result[:daily]).to_not be_empty

    expect(result).to_not have_key :minutely
    expect(result).to_not have_key :alerts
  end
end
