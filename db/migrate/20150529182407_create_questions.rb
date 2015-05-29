class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :test_id, null: false
      t.text :text

      t.timestamps
    end
  end
end
