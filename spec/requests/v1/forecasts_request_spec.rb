require 'rails_helper'

describe 'Forecasts Requests', :vcr do
  describe 'GET /api/v1/forecast' do
    let(:location) { 'Austin,Tx' }
    let(:data) { JSON.parse(response.body, symbolize_names: true) }

    context 'with valid params' do
      before { get api_v1_forecast_path, params: { location: location } }

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'has the proper root keys' do
        expect(data).to have_key :data

        expect(data[:data]).to have_key :id
        expect(data[:data][:id]).to be nil

        expect(data[:data]).to have_key :type
        expect(data[:data][:type]).to eq 'forecast'

        expect(data[:data]).to have_key :attributes
        expect(data[:data][:attributes]).to_not be_empty
      end
    end

    context 'with invalid params' do
      before { get api_v1_forecast_path }

      it 'returns http status 400' do
        expect(response).to have_http_status 400
      end

      it 'returns reason its invalid' do
        expect(data).to have_key :error
        expect(data[:error][:details]).to eq 'No location provided'
      end
    end
  end
end
