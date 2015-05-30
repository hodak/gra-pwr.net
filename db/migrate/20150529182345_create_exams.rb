class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
