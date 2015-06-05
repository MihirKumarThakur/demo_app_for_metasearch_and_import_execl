class Employee < ActiveRecord::Base

	belongs_to :department

	validates_presence_of :department_id, :ssn, :name, :phone_number, :address, :salary

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
	    params.require(:employee).permit(:department_id, :ssn, :name, :phone_number, :address, :salary)
	  end

end


