class AddOmniauthFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :provider_uid, :string
    add_column :users, :token, :string
    add_column :users, :expires_at, :datetime

    add_index :users, :token, unique: true
  end
end
