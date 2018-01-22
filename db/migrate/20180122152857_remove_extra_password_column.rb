class RemoveExtraPasswordColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :designers, :password, :string
  end
end
