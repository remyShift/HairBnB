class CreateWigs < ActiveRecord::Migration[7.1]
  def change
    create_table :wigs do |t|
      t.string :name
      t.string :material
      t.string :color
      t.string :hair_style
      t.string :length
      t.string :address
      t.integer :price

      t.timestamps
    end
  end
end
