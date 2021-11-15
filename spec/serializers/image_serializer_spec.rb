require 'rails_helper'

describe ImageSerializer do
  let(:data) do
    {
      url: 'thisawesomeimage.com',
      author: 'awesome person'
    }
  end
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
    }.to_json
  end

  it 'serializes the data' do
    result = ImageSerializer.serialize(data)

    expect(result).to eq(expected)
  end
end
