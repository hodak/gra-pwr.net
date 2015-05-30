class CreateUserExams < ActiveRecord::Migration
  def change
    create_table :user_exams, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.uuid :exam_id, null: false
      t.integer :repeat
      t.integer :repeat_wrong

      t.timestamps
    end
  end
end
