class CreateContractCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :contract_categories do |t|
      t.belongs_to :contract, foreign_key: true
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
