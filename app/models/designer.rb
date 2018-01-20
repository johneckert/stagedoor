class Designer < ApplicationRecord
  has_many :designer_categories
  has_many :categories, through: :designer_categories
  has_many :contracts
end
