require 'rails_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password_confirmation }

  it 'should create an api key on creation' do
    user = User.create(email: 'tanner', password: 'hello', password_confirmation: 'hello')

    user.reload

    expect(user.api_key).to be_a String
  end

  it 'can validate and api key' do
    users = create_list :user, 2

    result1 = User.valid_api_key?(users.first.api_key)
    result2 = User.valid_api_key?('asdfasdfasdf')

    expect(result1).to be true
    expect(result2).to be false
  end
end
