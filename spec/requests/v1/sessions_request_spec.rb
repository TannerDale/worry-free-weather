require 'rails_helper'

describe 'Sessions Requests' do
  let(:parsed) { JSON.parse(response.body, symbolize_names: true) }
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  describe 'POST /v1/sessions' do
    let(:params) { { email: user.email, password: 'hello' } }

    context 'with valid params' do
      let!(:user) { create :user, password: 'hello', password_confirmation: 'hello' }

      before { post api_v1_sessions_path, headers: headers, params: params.to_json }

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns the users email and api key' do
        expect(parsed[:data][:id].to_i).to eq(user.id)
        expect(parsed[:data][:attributes][:api_key]).to eq(user.api_key)
      end
    end

    context 'with invalid params' do
      let!(:user) { create :user, password: 'hello', password_confirmation: 'hello' }

      it 'rejects no email' do
        post api_v1_sessions_path, headers: headers, params: params.merge({ email: '' }).to_json

        expect(response).to have_http_status 400
        expect(parsed[:error][:details]).to eq('Invalid email or password')
      end

      it 'rejects no password' do
        post api_v1_sessions_path, headers: headers, params: params.merge({ password: '' }).to_json

        expect(response).to have_http_status 400
        expect(parsed[:error][:details]).to eq('Invalid email or password')
      end

      it 'rejects incorrect password' do
        post api_v1_sessions_path, headers: headers, params: params.merge({ password: 'asdfad' }).to_json

        expect(response).to have_http_status 400
        expect(parsed[:error][:details]).to eq('Invalid email or password')
      end
    end
  end
end
