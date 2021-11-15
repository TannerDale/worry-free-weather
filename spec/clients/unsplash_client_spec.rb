require 'rails_helper'

describe UnsplashClient, :vcr do
  let(:url) { '/search/photos?query=Austin' }

  it 'returns the data' do
    result = UnsplashClient.fetch(url)

    expect(result).to be_a Hash
    expect(result).to_not be_empty
    expect(result).to have_key :results
    expect(result[:results]).to be_an Array
  end
end
