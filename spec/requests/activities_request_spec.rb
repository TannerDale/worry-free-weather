require 'rails_helper'

describe 'Activities Requests', :vcr do
  let(:parsed) { JSON.parse(response.body, symbolize_names: true) }
  let(:data) { parsed[:data] }
  let(:attributes) { data[:attributes] }

  before :each do
    get api_v1_activities_path, params: { destination: 'austin,tx' }
  end

  it 'has status code 200' do
    expect(response).to have_http_status 200
  end

  it 'returns the proper info' do
    expect(data[:id]).to be nil
    expect(data[:type]).to eq('activities')
    expect(attributes.keys).to eq(%i[destination forecast activities])

    expect(attributes[:destination]).to eq('austin,tx')
    expect(attributes[:forecast]).to be_a Hash
    expect(attributes[:activities]).to be_an Array
    expect(attributes[:activities].size).to eq 2
  end
end
