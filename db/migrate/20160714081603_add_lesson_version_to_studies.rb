class AddLessonVersionToStudies < ActiveRecord::Migration[5.0]
  def change
    add_column :studies, :lesson_version_id, :integer
    add_foreign_key :studies, :versions, column: :lesson_version_id
  end
end
