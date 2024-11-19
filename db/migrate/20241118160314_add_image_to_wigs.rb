class AddImageToWigs < ActiveRecord::Migration[7.1]
  def change
    add_column :wigs, :image, :string
  end
end
