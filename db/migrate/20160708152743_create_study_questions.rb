class CreateStudyQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :study_questions do |t|
      t.belongs_to :study, foreign_key: true
      t.belongs_to :question, foreign_key: true
    end
  end
end
