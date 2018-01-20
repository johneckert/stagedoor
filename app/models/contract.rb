class Contract < ApplicationRecord
  belongs_to :venue
  belongs_to :user
  belongs_to :category
end
