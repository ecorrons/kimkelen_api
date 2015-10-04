class StudentCareerSchoolYear < ActiveRecord::Base
  self.table_name = "student_career_school_year"

  belongs_to :student
  belongs_to :career_school_year
end
