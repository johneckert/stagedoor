class Contract < ApplicationRecord
  belongs_to :venue
  belongs_to :designer
  has_many :contract_categories
  has_many :categories, through: :contract_categories
end
