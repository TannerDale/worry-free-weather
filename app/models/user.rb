class User < ApplicationRecord
  has_secure_password

  after_validation :assign_api_key

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  def assign_api_key
    self.api_key = ApiKey.generate
  end
end
