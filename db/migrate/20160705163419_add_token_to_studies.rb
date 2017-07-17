class AddTokenToStudies < ActiveRecord::Migration[5.0]
  def change
    add_column :studies, :token, :string
  end
end
