class City < ActiveRecord::Base
	self.table_name = "city"

	belongs_to :address
	belongs_to :state

	def to_builder
    Jbuilder.new do |city|
    	city.name name
    	city.state state.to_builder
    end
  end
end