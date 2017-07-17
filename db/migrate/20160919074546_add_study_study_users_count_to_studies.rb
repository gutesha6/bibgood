class AddStudyStudyUsersCountToStudies < ActiveRecord::Migration[5.0]
  def change
    add_column :studies, :study_users_count, :integer, default: 0
  end
end
