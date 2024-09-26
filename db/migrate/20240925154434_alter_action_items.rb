class AlterActionItems < ActiveRecord::Migration[6.1]
  def change
    remove_reference :action_items, :itemable, polymorphic: true, null: false
    add_reference :action_items, :itemable, polymorphic: true, null: true
  end
end
