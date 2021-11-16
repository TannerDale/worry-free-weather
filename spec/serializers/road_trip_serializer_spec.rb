require 'rails_helper'

describe RoadTripSerializer do
  let(:trip) do
    {
      start_city: 'austin',
      end_city: 'denver',
      travel_time: 'time',
      weather: { temp: 33, conditions: 'cold' }
    }
  end
  let(:result) { RoadTripSerializer.serialize(trip) }
  let(:parsed) { JSON.parse(result, symbolize_names: true) }

  it 'has the data serialized to json api specs' do
    expect(parsed.keys).to eq([:data])

    expect(parsed[:data].keys).to eq(%i[id type attributes])
    expect(parsed[:data][:id]).to be nil
    expect(parsed[:data][:type]).to eq('roadtrip')

    expect(parsed[:data][:attributes].keys).to eq(%i[start_city end_city travel_time weather])
  end
end
