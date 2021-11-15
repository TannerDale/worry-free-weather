require 'rails_helper'

describe ActivityFacade, :vcr do
  let(:location) { 'Austin, TX' }
  let!(:response) { ActivityFacade.activities(location) }
  let!(:parsed) { JSON.parse(response, symbolize_names: true) }
  let!(:data) { parsed[:data] }
  let!(:attributes) { data[:attributes] }

  it 'returns the proper keys and value data types' do
    expect(parsed).to be_a Hash
    expect(parsed).to have_key :data
    expect(data).to have_key :id
    expect(data).to have_key :type
    expect(data).to have_key :attributes

    expect(data[:attributes].keys).to eq(%i[destination forecast activities])
  end

  it 'returns proper id and type' do
    expect(data[:id]).to be nil
    expect(data[:type]).to eq('activities')
    expect(data[:attributes]).to be_a Hash
  end

  it 'returns proper attributes' do
    expect(attributes[:destination]).to eq(location)

    expect(attributes[:forecast].keys).to eq(%i[summary temperature])
    expect(attributes[:forecast][:temperature]).to match(/\d+\sF/)
    expect(attributes[:forecast][:summary]).to be_a String

    expect(attributes[:activities]).to be_an Array
    expect(attributes[:activities].size).to eq 2
  end

  it 'has proper activity info' do
    attributes[:activities].each do |act|
      expect(act.keys).to eq(%i[title type participants price])
    end
  end

  describe 'with different temps' do
    it 'provides a recreational' do
      allow(OpenWeatherService).to receive(:current_weather_data)
        .and_return({ summary: 'headsf', temp: 74 })

      data = JSON.parse(ActivityFacade.activities(location), symbolize_names: true)
      data = data[:data][:attributes]

      has_recreational = data[:activities].any? do |act|
        act[:type] == 'recreational'
      end

      expect(has_recreational).to be true
    end

    it 'provides a busywork' do
      allow(OpenWeatherService).to receive(:current_weather_data)
        .and_return({ summary: 'headsf', temp: 55 })

      data = JSON.parse(ActivityFacade.activities(location), symbolize_names: true)
      data = data[:data][:attributes]

      has_busywork = data[:activities].any? do |act|
        act[:type] == 'busywork'
      end

      expect(has_busywork).to be true
    end

    it 'provides a cooking' do
      allow(OpenWeatherService).to receive(:current_weather_data)
        .and_return({ summary: 'headsf', temp: 30 })

      data = JSON.parse(ActivityFacade.activities(location), symbolize_names: true)
      data = data[:data][:attributes]

      has_cooking = data[:activities].any? do |act|
        act[:type] == 'cooking'
      end

      expect(has_cooking).to be true
    end
  end
end
