class State < ActiveRecord::Base
	self.table_name = "state"

	belongs_to :country

	def to_builder
    Jbuilder.new do |state|
    	state.name name
    	state.country country.to_builder
    end
  end
end
