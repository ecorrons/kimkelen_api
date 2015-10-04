class CourseSubjectStudentMark < ActiveRecord::Base
  self.table_name = "course_subject_student_mark"

  belongs_to :course_subject_student

  def to_builder
    Jbuilder.new do |course_subject_student_mark|
      course_subject_student_mark.mark_number mark_number
      course_subject_student_mark.mark mark
      course_subject_student_mark.is_free is_free
    end
	end
end
