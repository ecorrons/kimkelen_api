class DisciplinarySanction < ActiveRecord::Base
	self.table_name = "student_advice"

	belongs_to :student
	belongs_to :school_year
	belongs_to :disciplinary_sanction_type

	def to_builder
		Jbuilder.new do |sanction|
			sanction.disciplinary_sanction_type disciplinary_sanction_type.name
			sanction.value value
			sanction.request_date request_date
			sanction.resolution_date resolution_date
			sanction.number number
		end
	end
end
