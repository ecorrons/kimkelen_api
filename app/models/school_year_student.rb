class SchoolYearStudent < ActiveRecord::Base
	self.table_name = "school_year_student"

	belongs_to :student
	belongs_to :school_year

end
