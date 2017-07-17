class AddLessonVersionToExercizes < ActiveRecord::Migration[5.0]
  def change
    add_column :exercizes, :lesson_version_id, :integer
    add_foreign_key :exercizes, :versions, column: :lesson_version_id
  end
end
