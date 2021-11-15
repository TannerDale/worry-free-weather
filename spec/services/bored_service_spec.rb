require 'rails_helper'

describe BoredService, :vcr do
  let(:type) { 'recreational' }
  let(:result) { BoredService.activity(type) }

  it 'filters activity to required data' do
    expect(result.keys).to eq(%i[title type participants price])
  end
end
