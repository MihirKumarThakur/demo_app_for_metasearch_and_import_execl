class AddExpenseToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :expense, :integer
  end
end
