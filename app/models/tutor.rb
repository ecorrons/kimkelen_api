class Tutor < ActiveRecord::Base
	self.table_name = "tutor"

	belongs_to :person
	has_many :student_tutors
	has_many :students, through: :student_tutors
	belongs_to :tutor_type

	def to_builder
	  Jbuilder.new do |tutor|
	    tutor.id id
	    tutor.tutor_type tutor_type.to_builder
	    tutor.person person.to_builder
	    tutor.students students.map { |st| st.to_builder_for_tutor.attributes! }
	  end
	end
end


