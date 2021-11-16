require 'rails_helper'

describe RoadTripFacade, :vcr do
  describe 'with possible road trip' do
    let!(:response) { RoadTripFacade.road_trip('denver,co', 'austin,tx') }

    it 'returns a struct' do
      expect(response).to be_a Hash
    end

    it 'has the correct travel time' do
      expect(response[:travel_time]).to eq('14 hours, 9 minutes')
    end

    it 'has the correct weather data' do
      expect(response[:weather_at_eta]).to be_a Hash
      expect(response[:weather_at_eta][:temperature]).to be_a Float
      expect(response[:weather_at_eta][:conditions]).to be_a String
    end
  end

  describe 'with impossible road trip' do
    let!(:response) { RoadTripFacade.road_trip('london', 'austin,tx') }

    it 'returns empty weather and impossible time' do
      expect(response[:travel_time]).to eq('impossible')
      expect(response[:weather_at_eta]).to be_empty
    end
  end
end
