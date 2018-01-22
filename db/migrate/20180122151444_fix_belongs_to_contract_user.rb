class FixBelongsToContractUser < ActiveRecord::Migration[5.1]
  def change
    remove_belongs_to :contracts, :user
    add_belongs_to :contracts, :designer
  end
end
