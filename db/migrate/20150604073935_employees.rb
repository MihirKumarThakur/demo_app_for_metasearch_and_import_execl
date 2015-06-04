class Employees < ActiveRecord::Migration
  def change
  	create_table :employees do |t|

  		t.belongs_to :department

  		t.string :ssn
  		t.string :name
  		t.string :phone_number
  		t.string :address
  		t.string :salary

  		t.timestamps null: false
  	end
  end
end
