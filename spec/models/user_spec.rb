require 'rails_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password_confirmation }

  it 'should create an api key on creation' do
    user = User.create(email: 'tanner', password: 'hello', password_confirmation: 'hello')

    user.reload

    expect(user.api_key).to be_a String
  end
end
