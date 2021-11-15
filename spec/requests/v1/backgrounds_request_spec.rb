require 'rails_helper'

describe 'Backgrounds Requests', :vcr do
  let(:city) { 'austin' }
  let(:parsed) { JSON.parse(response.body, symbolize_names: true) }
  let(:data) { parsed[:data] }
  let(:attributes) { data[:attributes] }

  context 'with valid params' do
    before { get api_v1_backgrounds_path, params: { location: city } }

    it 'returns status code 200' do
      expect(response).to have_http_status 200
    end

    it 'returns the correct keys' do
      expect(data).to have_key :id
      expect(data[:id]).to be nil

      expect(data).to have_key :type
      expect(data[:type]).to eq('image')

      expect(data).to have_key :attributes
      expect(data[:attributes]).to be_a Hash

      expect(attributes).to have_key :image_url
      expect(attributes[:image_url]).to be_a String

      expect(attributes).to have_key :author_name
      expect(attributes[:author_name]).to be_a String
    end
  end

  context 'with invalid params' do
    before { get api_v1_backgrounds_path }

    it 'returns status code 400' do
      expect(response).to have_http_status 400
    end

    it 'returns the reason why it was invalid' do
      expect(parsed[:error][:details]).to eq('No location provided')
    end
  end
end
