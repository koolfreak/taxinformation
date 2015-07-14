class AddUserIdToDailyExpense < ActiveRecord::Migration
  def change
    add_column :daily_expenses, :user_id, :integer
    add_index :daily_expenses, :user_id
  end
end
