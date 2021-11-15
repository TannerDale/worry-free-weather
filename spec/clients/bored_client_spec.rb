require 'rails_helper'

describe BoredClient, :vcr do
  let(:type) { 'recreational' }
  let(:url) { "/api/activity?type=#{type}" }

  it 'returns an activity of the correct type' do
    result = BoredClient.fetch(url)

    expect(result).to be_a Hash

    expect(result.keys).to eq(%i[activity type participants price link key accessibility])
  end
end
