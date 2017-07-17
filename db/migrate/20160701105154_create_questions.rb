class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.belongs_to :lesson, foreign_key: true
      t.integer :position
      t.string :body
      t.text :notes

      t.timestamps
    end
  end
end
