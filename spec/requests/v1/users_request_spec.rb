require 'rails_helper'

describe 'Users Requests' do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
  let(:parsed) { JSON.parse(response.body, symbolize_names: true) }
  let(:params) { { email: 'hello', password: 'world', password_confirmation: 'world' } }

  describe 'POST /v1/users' do
    context 'with valid params' do
      before { post api_v1_users_path, headers: headers, params: params.to_json }

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end

      it 'returns the users email and api key' do
        expect(parsed[:data][:attributes][:email]).to eq('hello')
        expect(parsed[:data][:attributes][:api_key]).to be_a String
      end

      it 'doesnt return the users password' do
        expect(parsed[:data][:attributes]).to_not have_key :password
        expect(parsed[:data][:attributes]).to_not have_key :password_confirmation
      end
    end

    context 'with invalid params' do
      let!(:existing_user) { create :user, email: 'tree' }

      it 'rejects no email' do
        post api_v1_users_path, headers: headers, params: params.merge({ email: '' }).to_json

        expect(response).to have_http_status 400
        expect(parsed[:error][:details]).to include("Email can't be blank")
      end

      it 'rejects already taken email' do
        post api_v1_users_path, headers: headers, params: params.merge({ email: 'tree' }).to_json

        expect(response).to have_http_status 400
        expect(parsed[:error][:details]).to include('Email has already been taken')
      end

      it 'rejects no password' do
        post api_v1_users_path, headers: headers, params: params.merge({ password: '' }).to_json

        expect(response).to have_http_status 400
        expect(parsed[:error][:details]).to include("Password can't be blank")
      end

      it 'rejects no password confirmation' do
        post api_v1_users_path, headers: headers, params: params.merge({ password_confirmation: '' }).to_json

        expect(response).to have_http_status 400
        expect(parsed[:error][:details]).to include("Password confirmation can't be blank")
      end

      it 'rejects mismatched password and password_confirmation' do
        post api_v1_users_path, headers: headers, params: params.merge({ password_confirmation: 'asdfas' }).to_json

        expect(response).to have_http_status 400
        expect(parsed[:error][:details]).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
