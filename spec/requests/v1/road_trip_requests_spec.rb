require 'rails_helper'

describe 'Road Trip Requests', :vcr do
  let!(:user) { create :user }
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
  let(:parsed) { JSON.parse(response.body, symbolize_names: true) }
  let(:data) { parsed[:data] }
  let(:attributes) { data[:attributes] }

  describe 'POST /v1/road_trips' do
    let(:params) { { origin: 'austin,tx', destination: 'denver,co', api_key: user.api_key } }

    context 'with valid params' do
      before { post api_v1_road_trip_path, headers: headers, params: params.to_json }

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns a road trip' do
        expect(parsed).to be_a Hash
        expect(parsed).to have_key :data

        expect(data[:id]).to be nil
        expect(data[:type]).to eq('roadtrip')

        expect(attributes[:start_city]).to eq('austin,tx')
        expect(attributes[:end_city]).to eq('denver,co')
        expect(attributes[:travel_time]).to eq('14 hours, 9 minutes')

        expect(attributes[:weather_at_eta]).to be_a Hash
        expect(attributes[:weather_at_eta].size).to eq 2
      end
    end

    describe 'with invalid params' do
      it 'rejects no origin city' do
        post api_v1_road_trip_path, headers: headers, params: params.merge({ origin: '' }).to_json

        expect(response).to have_http_status 400
        expect(parsed[:error][:details]).to eq('Missing origin field(s)')
      end

      it 'rejects no destination city' do
        post api_v1_road_trip_path, headers: headers, params: params.merge({ destination: '' }).to_json

        expect(response).to have_http_status 400
        expect(parsed[:error][:details]).to eq('Missing destination field(s)')
      end

      it 'has both missing params when no destination and origin' do
        post api_v1_road_trip_path, headers: headers, params: params.merge({ destination: '', origin: '' }).to_json

        expect(response).to have_http_status 400
        expect(parsed[:error][:details]).to eq('Missing destination and origin field(s)')
      end

      it 'rejects no api key' do
        post api_v1_road_trip_path, headers: headers, params: params.merge({ api_key: '' }).to_json

        expect(response).to have_http_status 401
        expect(parsed[:error][:details]).to eq('No api key provided')
      end

      it 'rejects incorrect api key' do
        post api_v1_road_trip_path, headers: headers, params: params.merge({ api_key: 'asdfasd' }).to_json

        expect(response).to have_http_status 401
        expect(parsed[:error][:details]).to eq('Invalid api key')
      end
    end
  end
end
