class AddAdminToDesigners < ActiveRecord::Migration[5.1]
  def change
    add_column :designers, :admin, :boolean, :default => false
  end
end
