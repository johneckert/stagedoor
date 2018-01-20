class Category < ApplicationRecord
  has_many :designer_categories
  has_many :designers, through: :designer_categories
  has_many :contracts
end
