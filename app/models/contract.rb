class Contract < ApplicationRecord
  belongs_to :venue
  belongs_to :designer
  has_many :contract_categories
  has_many :categories, through: :contract_categories
  validates :show_name, presence: true
  validates :fee, presence: true, numericality: {greater_than: 0}
  validates :categories, presence: true
  validate :company_must_own_venue

  def company_must_own_venue
    ven_comp = Venue.find(venue_id).company
    if ven_comp != Company.find(company_id)
      errors.add(:company, "must own the selected venue. #{ven_comp.name} is the company that owns this venue.")
    end
  end

  def company
   self.venue.company if self.venue
  end

  def company_id
      self.venue.company_id if self.venue
  end

  def company_id=(id)
    self.venue.company_id = id
  end

end
