class MoveAssistantBooleanToContract < ActiveRecord::Migration[5.1]
  def change
    remove_column :categories, :assistant
    add_column :contracts, :assistant, :boolean
  end
end
