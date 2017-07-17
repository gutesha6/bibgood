class AddLessonVersionToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :lesson_version_id, :integer
    add_foreign_key :questions, :versions, column: :lesson_version_id
  end
end
