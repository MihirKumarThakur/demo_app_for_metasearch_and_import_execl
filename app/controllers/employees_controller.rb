class EmployeesController < ApplicationController

	def index
		@employees = Employee.order(:id)
		@employees = Employee.search(params[:search])
		@employees = @search.all
		respond_to do |format|

			format.html
		      # format.csv { send_data @products.to_csv }
		      # format.xls # { send_data @products.to_csv(col_sep: "\t") }
  		end
	end
end



# def index
#   @search = Article.search(params[:search])
#   @articles = @search.all   # load all matching records
#   # @articles = @search.relation # Retrieve the relation, to lazy-load in view
#   # @articles = @search.paginate(:page => params[:page]) # Who doesn't love will_paginate?
# end