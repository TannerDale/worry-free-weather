require 'rails_helper'

describe UserSerializer do
  let!(:user) { create :user }
  let(:raw) { UserSerializer.new(user).to_json }
  let(:parsed) { JSON.parse(raw, symbolize_names: true) }

  it 'serializes a user' do
    expect(parsed).to have_key :data

    expect(parsed[:data][:id].to_i).to eq(user.id)
    expect(parsed[:data][:type]).to eq('users')

    expect(parsed[:data][:attributes][:email]).to eq(user.email)
    expect(parsed[:data][:attributes][:api_key]).to eq(user.api_key)
  end
end
