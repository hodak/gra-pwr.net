class RenameTestsToExams < ActiveRecord::Migration
  def change
    rename_table :tests, :exams
    rename_table :user_tests, :user_exams
    rename_column :questions, :test_id, :exam_id
    rename_column :user_answers, :user_test_id, :user_exam_id
    rename_column :user_exams, :test_id, :exam_id
  end
end
