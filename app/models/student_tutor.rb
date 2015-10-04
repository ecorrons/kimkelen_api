class StudentTutor < ActiveRecord::Base
	self.table_name = "student_tutor"

	belongs_to :student
  belongs_to :tutor

end
