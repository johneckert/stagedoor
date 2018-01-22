class RemoveAssistantsFromContract < ActiveRecord::Migration[5.1]
  def change
    remove_column :contracts, :assistant, :boolean
  end
end
