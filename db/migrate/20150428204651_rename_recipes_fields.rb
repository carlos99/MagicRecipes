class RenameRecipesFields < ActiveRecord::Migration
  def change
    rename_column :recipes, :desciption, :description
end
end
