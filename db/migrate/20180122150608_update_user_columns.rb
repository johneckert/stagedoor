class UpdateUserColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :designers, :name, :string
    remove_column :designers, :union_id, :integer
    add_column :designers, :username, :string
    add_column :designers, :password_digest, :string
    add_column :designers, :age, :integer
    add_column :designers, :ethnicity, :string
  end
end
