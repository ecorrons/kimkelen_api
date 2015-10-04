class CourseSubjectStudentExamination < ActiveRecord::Base
	self.table_name = "course_subject_student_examination"

	belongs_to :course_subject_student

	def to_builder
		Jbuilder.new do |course_subject_student_examination|
  			course_subject_student_examination.mark mark
  			course_subject_student_examination.is_absent is_absent
  			course_subject_student_examination.examination_number examination_number
  			course_subject_student_examination.date date

  	end
	end
end

