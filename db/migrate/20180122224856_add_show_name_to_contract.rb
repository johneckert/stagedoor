class AddShowNameToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :show_name, :string
  end
end
