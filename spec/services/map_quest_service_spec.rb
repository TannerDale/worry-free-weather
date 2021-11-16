require 'rails_helper'

describe MapQuestService, :vcr do
  describe 'geocoding' do
    let(:response) do
      {
        info: {
          key: 'value'
        },
        options: {
          option: '1',
          options: '2'
        },
        results: [
          {
            providedLocation: {
              location: 'Austin, Tx'
            },
            locations: [
              {
                latLng: {
                  lat: 30.264979,
                  lng: -97.746598
                }
              }
            ]
          }
        ]
      }
    end

    before :each do
      allow(MapQuestClient).to receive(:fetch).and_return(response)
    end

    it 'can filter the data down to just the location info' do
      result = MapQuestService.location_lat_lon('Austin, Tx')
      expected = {
        lat: 30.264979,
        lng: -97.746598
      }

      expect(result).to eq(expected)
    end
  end

  describe 'road tripping' do
    let!(:response) { MapQuestService.road_trip('denver,co', 'austin,tx') }

    it 'filters down to just the time' do
      expect(response).to be_a Hash

      expect(response[:time]).to be_an Integer
      expect(response[:destination_coords]).to be_a Hash
      expect(response[:destination_coords].size).to eq 2
    end
  end
end
