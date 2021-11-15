require 'rails_helper'

describe ImageFacade, :vcr do
  let(:city) { 'Austin, tx' }
  let(:result) { ImageFacade.location_image(city) }
  let(:data) { JSON.parse(result, symbolize_names: true) }
  let(:image) { { url: 'thisawesomeimage.com', author: 'awesome person' } }
  let(:expected) do
    {
      data: {
        id: nil,
        type: 'image',
        attributes: {
          image_url: 'thisawesomeimage.com',
          author_name: 'awesome person'
        }
      }
    }
  end

  before :each do
    allow(UnsplashService).to receive(:location_image).and_return(image)
  end

  it 'returns the correct data' do
    expect(data).to eq(expected)
  end
end
