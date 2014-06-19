class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :handle
      t.timestamps
    end

    change_table :pictures do |p|
      p.references :category
    end
  end
end
