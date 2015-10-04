class AbsenceType < ActiveRecord::Base
	self.table_name = "absence_type"

	has_many :student_attendances

end
