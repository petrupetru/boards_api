class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.belongs_to :column
      t.string :type
      t.string :title
      t.string :description
      t.date :due_date

      t.timestamps
    end
  end
end
