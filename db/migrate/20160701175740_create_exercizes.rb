class CreateExercizes < ActiveRecord::Migration[5.0]
  def change
    create_table :exercizes do |t|
      t.belongs_to :lesson, foreign_key: true
      t.string :body
      t.text :notes
      t.integer :difficulty

      t.timestamps
    end
  end
end
