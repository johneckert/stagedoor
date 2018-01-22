class Venue < ApplicationRecord
  belongs_to :company
  belongs_to :location
  has_many :contracts
end
