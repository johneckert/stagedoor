class Company < ApplicationRecord
  has_many :venues
  has_many :locations, through: :venues
  has_many :contracts, through: :venues
  validates :name, presence: true

end
