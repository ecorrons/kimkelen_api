class StudentApprovedCareerSubject < ActiveRecord::Base
	self.table_name = "student_approved_career_subject"

	belongs_to :student
	belongs_to :school_year
	
end
