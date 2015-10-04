class Country < ActiveRecord::Base
	self.table_name = "country"

	def to_builder
	  Jbuilder.new do |country|
	  	country.name name
	  end
	end
end