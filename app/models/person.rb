class Person < ActiveRecord::Base
  self.table_name = "person"

  has_one :student
  has_one :tutor
  
  belongs_to :address

  def to_builder
    Jbuilder.new do |person|
      person.firstname firstname
      person.lastname lastname
      person.identification_type IdentificationType::get_option identification_type
      person.identification_number identification_number  
      person.phone phone 
      person.email email
      person.address address.to_builder
	end
  end
end
