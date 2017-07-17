class AddImageToLessons < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :image, :string
  end
end
