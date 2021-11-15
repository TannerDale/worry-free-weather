require 'rails_helper'

describe UnsplashService, :vcr do
  let(:city) { 'austin' }
  let!(:result) { UnsplashService.location_image(city) }

  describe 'filtering data' do
    it 'gets the image url' do
      expect(result).to have_key :url
      expect(result[:url]).to be_a String
    end

    it 'gets the author of the image' do
      expect(result).to have_key :author
      expect(result[:author]).to be_a String
    end
  end
end
