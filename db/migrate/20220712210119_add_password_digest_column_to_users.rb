class AddPasswordDigestColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_digest, :text
  end
  add_index :users, :email, unique: true
end

