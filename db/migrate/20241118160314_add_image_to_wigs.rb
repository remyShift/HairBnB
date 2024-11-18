class AddImageToWigs < ActiveRecord::Migration[7.1]
  def change
    add_column :image, :string
  end
end
