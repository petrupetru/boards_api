class CreateActionItems < ActiveRecord::Migration[6.1]
  def change
    create_table :action_items do |t|
      t.string :name
      t.integer :status
      t.references :task, null: false, foreign_key: true
      t.references :itemable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
