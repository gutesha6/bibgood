class CreateStudyRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :study_requests do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :study, foreign_key: true
      t.string :title
      t.text :body
      t.integer :status, default: 0
      t.text :response

      t.timestamps
    end
  end
end
