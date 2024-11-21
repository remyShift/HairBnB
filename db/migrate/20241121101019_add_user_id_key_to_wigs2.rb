class AddUserIdKeyToWigs2 < ActiveRecord::Migration[7.1]
  def change
    add_reference :wigs, :user, foreign_key: true
  end
end
