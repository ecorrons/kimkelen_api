class CareerSubject < ActiveRecord::Base
	self.table_name = "career_subject"

	has_many :student_approved_career_subjects
	has_many :careear_subject_school_years
	
end
