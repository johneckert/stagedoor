class ChangeAgeToBirthYear < ActiveRecord::Migration[5.1]
  def change
    rename_column :designers, :age, :birth_year
  end
end
