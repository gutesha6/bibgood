class CreateStudyUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :study_users do |t|
      t.belongs_to :study, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
