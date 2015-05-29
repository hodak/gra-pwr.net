class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.integer :user_test_id, null: false
      t.integer :answer_id, null: false

      t.timestamps
    end
  end
end
