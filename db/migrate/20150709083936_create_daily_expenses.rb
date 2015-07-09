class CreateDailyExpenses < ActiveRecord::Migration
  def change
    create_table :daily_expenses do |t|
      t.date :expenseDate
      t.float :amount
      t.string :items

      t.timestamps null: false
    end
  end
end
