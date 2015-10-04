class CourseSubject < ActiveRecord::Base
  self.table_name = "course_subject"

  has_many 	 :course_subject_students
  belongs_to :course
  belongs_to :career_subject_school_year
end
