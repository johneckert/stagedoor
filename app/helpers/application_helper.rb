module ApplicationHelper

  def cons_mean_fee(contracts)
    fees = all_fees(contracts)
    if fees.length > 0
      fees.sum / fees.length
    else
      "N/A"
    end
  end

  def cons_median_fee(contracts)
    fees = all_fees(contracts)
    if fees.length > 0
      fees.sort
      fees[(fees.length / 2)]
    else
      "N/A"
    end
  end

  def cons_mode_fee(contracts)
    fees = all_fees(contracts)
    if fees.length > 0
      fee_hash = fees.reduce(Hash.new(0)) { |a, b| a[b] += 1; a }
      fee_hash.invert.sort.last.last
    else
      "N/A"
    end
  end

  def cons_min_fee(contracts)
    fees = all_fees(contracts)
    if fees.length > 0
      fees.sort.first
    else
      "N/A"
    end
  end

  def cons_max_fee(contracts)
    fees = all_fees(contracts)
    if fees.length > 0
      fees.sort.last
    else
      "N/A"
    end
  end

  private

  def all_fees(contracts)
    contracts.map { |c| c.fee }
  end
end
