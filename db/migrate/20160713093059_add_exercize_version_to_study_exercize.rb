class AddExercizeVersionToStudyExercize < ActiveRecord::Migration[5.0]
  def change
    add_column :study_exercizes, :exercize_version_id, :integer
    add_foreign_key :study_exercizes, :versions, column: :exercize_version_id
  end
end
