module ContractsHelper


  def average_fee(user)
    fees = all_fees_for_user(user)
    if fees.length > 0
      fees.sum / fees.length
    else
      "N/A"
    end
  end

  def max_fee(user)
    fees = all_fees_for_user(user)
    if fees.length > 0
      fees.sort.last
    else
      "N/A"
    end
  end

  def min_fee(user)
    fees = all_fees_for_user(user)
    if fees.length > 0
      fees.sort.first
    else
      "N/A"
    end
  end

  def all_fees_for_user(user)
    user.contracts.map {|c| c.fee}
  end

end
