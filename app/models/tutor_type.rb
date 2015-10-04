class TutorType < ActiveRecord::Base
	self.table_name = "tutor_type"

	def to_builder
		Jbuilder.new do |type|
			type.name name
		end
	end
end
