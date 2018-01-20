class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.belongs_to :location, foreign_key: true

      t.timestamps
    end
  end
end
