class CareerSubjectSchoolYear < ActiveRecord::Base
	self.table_name = "career_subject_school_year"

	belongs_to :career_subject
	belongs_to :school_year

end
