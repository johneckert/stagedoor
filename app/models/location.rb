class Location < ApplicationRecord
  has_many :companies
  has_many :venues, through: :companies
end
