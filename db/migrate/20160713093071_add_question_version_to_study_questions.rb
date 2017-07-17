class AddQuestionVersionToStudyQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :study_questions, :question_version_id, :integer
    add_foreign_key :study_questions, :versions, column: :question_version_id
  end
end
