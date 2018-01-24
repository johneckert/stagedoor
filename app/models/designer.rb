class Designer < ApplicationRecord
  has_many :contracts
  has_many :categories, through: :contracts
  has_secure_password

  validates :ethnicity, presence: true
  validates :gender, presence: true
  validates :username, presence: true
  validates :password_digest, presence: true
  validates :birth_year, presence: true
  validates :ethnicity, presence: true
  # Birth Year cant be greater than Time.now or less than 1900 or something, as well as show date
end
