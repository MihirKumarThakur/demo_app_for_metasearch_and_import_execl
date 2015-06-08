class EmployeesController < ApplicationController

	def index

		@employee = Employee.new
		if !(params[:employee]).blank?
			@q = Employee.ransack({"name_cont"=>params[:employee][:name],"city_eq"=>params[:employee][:city], "age_eq"=>params[:employee][:age]})
			@emp1 = @q.result.page params[:page]
		else
			@emp1 = Employee.all.page params[:page]
		end
		@employees = @emp1.order('name ASC')
		respond_to do |format|
			format.html
		end
	end


	def sort_by_first_character

		@employee = Employee.new
		
		 if params["name-sort"] != " " && params["age-sort"] == " "
			@emp = Employee.find_name_with_specified_range(params["name-sort"])
	
		elsif params["age-sort"]  != " " && params["name-sort"] == " "
			@emp = Employee.find_name_with_specified_age(params["age-sort"])
 		
 		elsif  params["age-sort"]  != " " && params["name-sort"] != " "
			age_start_with = params["age-sort"][0..1]
			upto_this_age = params["age-sort"][3..4]
			emp_with_name_intials_in_given_range = Employee.find_name_with_specified_range(params["name-sort"])
			@emp =  emp_with_name_intials_in_given_range.select { |emp| emp.age >= age_start_with.to_i && emp.age <= upto_this_age.to_i }

		else		
			@emp = Employee.all
		end
		@employees = Employee.where(id: @emp.map(&:id)).order('name ASC').page params[:page]
		render "index"
	end
end