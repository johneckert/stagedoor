class DropDesignerCategories < ActiveRecord::Migration[5.1]
  def change
    drop_table :designer_categories
  end
end
