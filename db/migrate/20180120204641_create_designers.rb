class CreateDesigners < ActiveRecord::Migration[5.1]
  def change
    create_table :designers do |t|
      t.string :name
      t.integer :union_id
      t.string :password
      t.string :gender

      t.timestamps
    end
  end
end
