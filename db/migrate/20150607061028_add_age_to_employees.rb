class AddAgeToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :age, :integer
  end
end
