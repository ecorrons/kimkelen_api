class Address < ActiveRecord::Base
	self.table_name = "address"

	has_one :person
	belongs_to :city

	def to_builder
    Jbuilder.new do |address|
     	address.street street
     	address.number number
     	address.floor floor
     	address.flat flat
     	address.city city.to_builder
		end
  end
end