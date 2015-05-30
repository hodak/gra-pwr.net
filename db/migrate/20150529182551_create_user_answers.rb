class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers, id: :uuid do |t|
      t.uuid :user_exam_id, null: false
      t.uuid :answer_id, null: false

      t.timestamps
    end
  end
end
