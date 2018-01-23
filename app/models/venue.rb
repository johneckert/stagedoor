class Venue < ApplicationRecord
  belongs_to :company
  belongs_to :location
  has_many :contracts

  def mean_fee
    if all_fees.length > 0
      all_fees.sum / all_fees.length
    else
      "N/A"
    end
  end

  def median_fee
    if all_fees.length > 0
      all_fees.sort
      all_fees[(all_fees.length / 2)]
    else
      "N/A"
    end
  end

  def mode_fee
    if all_fees.length > 0
      fee_hash = all_fees.reduce(Hash.new(0)) { |a, b| a[b] += 1; a }
      fee_hash.invert.sort.last
    else
      "N/A"
    end
  end

  def min_fee
    if all_fees.length > 0
      all_fees.sort.first
    else
      "N/A"
    end
  end

  def max_fee
    if all_fees.length > 0
      all_fees.sort.last
    else
      "N/A"
    end
  end

  private

  def all_fees
    self.contracts.map { |c| c.fee }
  end

end
