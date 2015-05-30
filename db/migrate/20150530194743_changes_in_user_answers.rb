class ChangesInUserAnswers < ActiveRecord::Migration
  def change
    rename_column :user_answers, :answer_id, :question_id
    add_column :user_answers, :answers, :text, array: true, null: false
  end
end
