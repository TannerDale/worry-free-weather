require 'rails_helper'

describe MapQuestService do
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
                lng: 97.746598
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
    result = MapQuestService.location_lat_lng('Austin, Tx')
    expected = {
      lat: 30.264979,
      lng: 97.746598
    }

    expect(result).to eq(expected)
  end
end
