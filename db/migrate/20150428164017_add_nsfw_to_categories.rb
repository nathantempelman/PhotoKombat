class AddNsfwToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :nsfw, :boolean
  end
end
