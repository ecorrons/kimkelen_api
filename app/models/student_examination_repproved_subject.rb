class StudentExaminationRepprovedSubject < ActiveRecord::Base
	self.table_name = "student_examination_repproved_subject"

	belongs_to :student_repproved_course_subject

	def to_builder
		Jbuilder.new do |student_examination_repproved_subject|
			student_examination_repproved_subject.mark mark
			student_examination_repproved_subject.is_absent is_absent
			student_examination_repproved_subject.date date
		end
	end
end
