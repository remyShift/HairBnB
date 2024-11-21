class RemoveUserIdKeyToWigs < ActiveRecord::Migration[7.1]
  def change
    remove_reference :wigs, :user, foreign_key: true
  end
end
