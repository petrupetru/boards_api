class TaskAddColumnArchivedAt < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :archived_at, :datetime
  end
end
