class AddCoordinatesToWigs < ActiveRecord::Migration[7.1]
  def change
    add_column :wigs, :latitude, :float
    add_column :wigs, :longitude, :float
  end
end
