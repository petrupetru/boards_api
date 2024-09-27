class ParaoiaAllTables < ActiveRecord::Migration[6.1]
  def change
    add_column :action_items, :deleted_at, :datetime
    add_index :action_items, :deleted_at

    add_column :columns, :deleted_at, :datetime
    add_index :columns, :deleted_at

    add_column :roles, :deleted_at, :datetime
    add_index :roles, :deleted_at

    add_column :tasks, :deleted_at, :datetime
    add_index :tasks, :deleted_at

    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at

    add_column :photos, :deleted_at, :datetime
    add_index :photos, :deleted_at

    add_column :documents, :deleted_at, :datetime
    add_index :documents, :deleted_at
  end
end
