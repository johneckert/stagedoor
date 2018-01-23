module ContractsHelper


  def average_fee(user)
    fees = all_fees_for_user(user)
    fees.sum / fees.length
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
    all_contracts_for_user(user).map {|c| c.fee}
  end

  def all_contracts_for_user(user)
    users_contracts = []
    Contract.all.each do |c|
      if c.designer = user
        users_contracts << c
      end
    end
  end
end
