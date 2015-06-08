class Employee < ActiveRecord::Base

	belongs_to :department

	max_paginates_per 10

	validates_presence_of :department_id, :ssn, :name, :phone_number, :city, :expense, :age, :email, :address, :salary

	validates :age,  numericality: { :greater_than => 20, :less_than_or_equal_to => 50 ,

										message: "only allows 20-50 age"
											}

	def self.find_name_with_specified_range(range)
		@emp = Employee.where(name: nil)
		name_start_with = range[0]
		upto_this_char =  range[2]
		employees = Employee.all
		employees.each do |em|
			[*(name_start_with..upto_this_char)].each do |letter|
				@emp << em if em.name.upcase.start_with?(letter)
			end
		end
		@emp
	end

	def self.find_name_with_specified_age(range)
		age_start_with = range[0..1]
		upto_this_age = range[3..4]
		@emp = Employee.where(age: [age_start_with..upto_this_age])
		@emp
	end

	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			employee = find_by_ssn(row["ssn"]) || new
			employee.attributes = row
			employee.save
		end
	end

	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
		when ".csv" then Csv.new(file.path, nil, :ignore)
		when ".xls" then Excel.new(file.path, nil, :ignore)
		when ".xlsx" then Roo::Spreadsheet.open(file.path)
		else raise "Unknown file type: #{file.original_filename}"
		end
	end

	private

	  def employee_params
	    params.require(:employee).permit(:department_id, :ssn, :name, :phone_number, :address, :salary, :age, :expense, :city, :age)
	  end

end


