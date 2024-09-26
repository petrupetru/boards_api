class AddBoardRefToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :board, null: false, foreign_key: true
  end
end
