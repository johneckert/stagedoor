class ChangeContractAssociations < ActiveRecord::Migration[5.1]
  def change
    remove_belongs_to :contracts, :category
  end
end
