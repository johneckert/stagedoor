class MoveContractTypeToVenue < ActiveRecord::Migration[5.1]
  def change
    remove_column :contracts, :contract_type, :string
    add_column :venues, :contract_type, :string
  end
end
