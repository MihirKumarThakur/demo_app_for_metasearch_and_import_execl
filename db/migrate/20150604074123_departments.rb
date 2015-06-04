class Departments < ActiveRecord::Migration
  def change
  	create_table :departments do |t|
  		t.string :department_name
  		t.string :department_id
  		t.string :department_location

  		t.timestamps null: false
  	end
  end
end
