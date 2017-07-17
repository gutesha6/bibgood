class CreateStudyUserExercizeTransitions < ActiveRecord::Migration[5.1]
  def change
    create_table :study_user_exercize_transitions do |t|
      t.string :to_state, null: false
      t.text :metadata, default: "{}"
      t.integer :sort_key, null: false
      t.integer :study_user_exercize_id, null: false
      t.boolean :most_recent, null: false
      t.timestamps null: false
    end

    add_index(:study_user_exercize_transitions,
              [:study_user_exercize_id, :sort_key],
              unique: true,
              name: "index_study_user_exercize_transitions_parent_sort")
    add_index(:study_user_exercize_transitions,
              [:study_user_exercize_id, :most_recent],
              unique: true,
              where: 'most_recent',
              name: "index_study_user_exercize_transitions_parent_most_recent")
  end
end
