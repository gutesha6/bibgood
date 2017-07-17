class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :description
      t.string :slug

      t.timestamps
    end
    add_index :lessons, :slug
  end
end
