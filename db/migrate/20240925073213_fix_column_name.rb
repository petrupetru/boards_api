class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :roles, :role, :name
  end
end
