class Designer < ApplicationRecord
  has_many :contracts
  has_many :categories, through: :contracts
  has_secure_password

  validates :ethnicity, presence: true
  validates :gender, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :birth_year, presence: true, numericality: {greater_than: 1900}
  validates :ethnicity, inclusion: {
    in: ["Asian or Indian subcontinent", "Black", "Hispanic", "Native American", "Pacific Islander", "White", "Other"],
    message: "must be selected."
    }




end
