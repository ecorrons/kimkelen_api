class CareerSchoolYear < ActiveRecord::Base
	self.table_name = "career_school_year"

	belongs_to :school_year
	has_many :student_attendances
end
