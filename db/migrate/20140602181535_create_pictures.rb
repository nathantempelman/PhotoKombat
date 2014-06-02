class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.string :url
      t.integer :user_id
      t.integer :rating

      t.timestamps
    end
  end
end
