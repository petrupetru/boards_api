class RemoveColumnsFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_columns(:users, :email, :name, :password)
  end
end
