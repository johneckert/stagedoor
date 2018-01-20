class ContractCategory < ApplicationRecord
  belongs_to :contract
  belongs_to :category
end
