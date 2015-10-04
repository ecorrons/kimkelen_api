class StudentAttendance < ActiveRecord::Base
	self.table_name = "student_attendance"

	belongs_to :student
	belongs_to :absence_type
	belongs_to :career_school_year

	scope :absences, -> { where.not(value: 0)}

	def to_builder
		Jbuilder.new do |sa|
			sa.absence_type absence_type.name
			sa.value value
			sa.day day
		end
	end
end

