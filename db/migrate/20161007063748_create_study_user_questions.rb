class CreateStudyUserQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :study_user_questions do |t|
      t.references :study_user, foreign_key: true
      t.references :study_question, foreign_key: true

      t.timestamps
    end
  end
end
