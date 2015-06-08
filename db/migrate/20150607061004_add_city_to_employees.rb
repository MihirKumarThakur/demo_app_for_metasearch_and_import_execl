class AddCityToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :city, :string
  end
end
