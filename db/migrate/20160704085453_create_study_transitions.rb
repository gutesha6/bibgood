class CreateStudyTransitions < ActiveRecord::Migration[5.0]
  def change
    create_table :study_transitions do |t|
      t.string :to_state, null: false
      t.json :metadata, default: {}
      t.integer :sort_key, null: false
      t.integer :study_id, null: false
      t.boolean :most_recent, null: false
      t.timestamps null: false
    end

    add_index(:study_transitions,
              [:study_id, :sort_key],
              unique: true,
              name: 'index_study_transitions_parent_sort')
    add_index(:study_transitions,
              [:study_id, :most_recent],
              unique: true,
              where: 'most_recent',
              name: 'index_study_transitions_parent_most_recent')
  end
end
