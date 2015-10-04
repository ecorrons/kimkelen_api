class SchoolYear < ActiveRecord::Base
	self.table_name = "school_year"

	has_many :career_school_years
	has_many :courses

	def to_builder
		Jbuilder.new do |school_year|
				school_year.year year
		end
	end

end
