class StudentRepprovedCourseSubject < ActiveRecord::Base
	self.table_name = "student_repproved_course_subject"

	belongs_to :course_subject_student
	has_many   :student_examination_repproved_subjects
end
