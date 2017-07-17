class CreateStudyUserExercizes < ActiveRecord::Migration[5.0]
  def change
    create_table :study_user_exercizes do |t|
      t.references :study_user, foreign_key: true
      t.references :study_exercize, foreign_key: true

      t.timestamps
    end
  end
end
