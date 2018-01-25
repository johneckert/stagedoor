class Category < ApplicationRecord
  has_many :contract_categories
  has_many :contracts, through: :contract_categories
  has_many :designers, through: :contracts
  validates :name, presence: true
end
