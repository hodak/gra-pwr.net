class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id, null: false
      t.text :text
      t.boolean :correct, null: false

      t.timestamps
    end
  end
end
