class CreateUserTests < ActiveRecord::Migration
  def change
    create_table :user_tests do |t|
      t.integer :user_id, null: false
      t.integer :test_id, null: false
      t.integer :repeat
      t.integer :repeat_wrong

      t.timestamps
    end
  end
end
