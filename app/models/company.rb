class Company < ApplicationRecord
  belongs_to :location
  has_many :venues
  has_many :contracts, through: :venues
end
