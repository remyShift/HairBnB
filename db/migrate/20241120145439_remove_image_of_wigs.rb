class RemoveImageOfWigs < ActiveRecord::Migration[7.1]
  def change
    remove_column :wigs, :image
  end
end
