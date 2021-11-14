require 'rails_helper'

describe MapQuestClient, :vcr do
  let(:url) { '/geocoding/v1/address?location=Austin, tx' }

  describe 'geocoding' do
    it 'can get info for a city' do
      result = MapQuestClient.fetch(url)

      expect(result).to be_a Hash
      expect(result.size).to eq 3
      expect(result).to have_key :info
      expect(result).to have_key :options
      expect(result).to have_key :results
    end
  end
end
