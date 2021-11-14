require 'rails_helper'

describe ForecastFacade, :vcr do
  let(:location) { 'Austin, TX' }
  let(:coords) do
    {
      lat: 30.264979,
      lon: -97.746598
    }
  end

  before :each do
    allow(MapQuestService).to receive(:location_lat_lng).and_return(coords)
  end

  it 'takes the coords and gets the corresponding weather' do
    result = ForecastFacade.weather_data('Austin, TX')

    expect(result).to be_a Hash
    expect(result).to_not be_empty

    expect(result).to have_key :current_weather
    expect(result[:current_weather]).to_not be_empty

    expect(result).to have_key :hourly_weather
    expect(result[:hourly_weather]).to_not be_empty

    expect(result).to have_key :daily_weather
    expect(result[:daily_weather]).to_not be_empty
  end
end
