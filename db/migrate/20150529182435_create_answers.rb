class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers, id: :uuid do |t|
      t.uuid :question_id, null: false
      t.text :text
      t.boolean :correct, default: false

      t.timestamps
    end
  end
end
