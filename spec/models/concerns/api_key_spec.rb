require 'rails_helper'

describe ApiKey do
  it 'can create an API key' do
    key = ApiKey.generate

    expect(key).to be_a String
  end
end
