class Contract < ApplicationRecord
  belongs_to :venue
  belongs_to :designer
  has_many :contract_categories
  has_many :categories, through: :contract_categories

  def company
    Company.find(self.venue.company_id) if self.venue
  end
end
