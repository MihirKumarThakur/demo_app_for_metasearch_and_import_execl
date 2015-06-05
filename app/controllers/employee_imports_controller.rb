class EmployeeImportsController < ApplicationController

	def imports
		 Employee.import(params[:file])
		 redirect_to root_url, notice: "Imported Employee successfully. "
  	end
end