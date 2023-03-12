class ChangeNicknameToUsername < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :nickname, :username
    add_column :users, :status, :integer, default: 0
  end
end
