class AddVideoIdToLessons < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :video_id, :string
  end
end
