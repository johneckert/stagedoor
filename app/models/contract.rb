class Contract < ApplicationRecord
  belongs_to :venue
  belongs_to :designer
  has_many :contract_categories
  has_many :categories, through: :contract_categories

  # def company
  #   self.venue.company if self.venue
  # end

  def company
   self.venue.company if self.venue
  end

  def company_id
      self.venue.company_id if self.venue
  end

  def company_id=(id)
    self.venue.company_id = id
  end

  def venue=(venue_name)
    self.venue = Venue.find_by(name: venue_name)
  end
end
