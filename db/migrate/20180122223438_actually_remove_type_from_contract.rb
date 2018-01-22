class ActuallyRemoveTypeFromContract < ActiveRecord::Migration[5.1]
  def change
    remove_column :contracts, :type, :string
  end
end
