class CreateStudyExercizes < ActiveRecord::Migration[5.0]
  def change
    create_table :study_exercizes do |t|
      t.references :study, foreign_key: true
      t.references :exercize, foreign_key: true
    end
  end
end
