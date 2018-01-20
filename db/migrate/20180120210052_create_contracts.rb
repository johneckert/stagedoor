class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts do |t|
      t.belongs_to :venue, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.belongs_to :category, foreign_key: true
      t.string :type
      t.integer :fee
      t.date :opening_date
      t.boolean :musical, default: false

      t.timestamps
    end
  end
end
