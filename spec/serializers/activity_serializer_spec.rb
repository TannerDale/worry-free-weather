require 'rails_helper'

describe ActivitySerializer do
  let(:data) do
    {
      destination: 'Austin, tx',
      forecast: {
        summary: 'awesome',
        temp: 72.6
      },
      activities: [
        {
          title: 'Take a bubble bath',
          type: 'relaxation',
          participants: 1,
          price: 0.5
        },
        {
          title: 'fun',
          type: 'cooking',
          participants: 3,
          price: 0.9
        }
      ]
    }
  end
  let!(:response) { ActivitySerializer.serialize(data) }
  let(:parsed) { JSON.parse(response, symbolize_names: true) }

  it 'has the proper keys' do
    expect(parsed).to be_a Hash

    expect(parsed).to have_key :data
    expect(parsed[:data].keys).to eq(%i[id type attributes])
  end

  it 'has the proper attributes' do
    expect(parsed[:data][:attributes].keys).to eq(%i[destination forecast activities])
  end
end
