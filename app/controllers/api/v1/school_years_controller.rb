class Api::V1::SchoolYearsController < Api::V1::ApiController

	def index
		@school_years = SchoolYear.all
	end
end