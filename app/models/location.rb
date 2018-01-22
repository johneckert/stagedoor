class Location < ApplicationRecord
  has_many :venues
  has_many :companies, through: :venues
end
