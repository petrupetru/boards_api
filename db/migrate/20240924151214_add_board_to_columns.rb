class AddBoardToColumns < ActiveRecord::Migration[6.1]
  def change
    add_reference :columns, :board, null: false, foreign_key: true
  end
end
