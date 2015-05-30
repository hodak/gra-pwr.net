class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions, id: :uuid do |t|
      t.uuid :exam_id, null: false
      t.text :text

      t.timestamps
    end
  end
end
