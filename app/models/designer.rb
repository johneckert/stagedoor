class Designer < ApplicationRecord
  has_many :contracts
  has_many :categories, through: :contracts
  has_secure_password
end
