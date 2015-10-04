class IdentificationType

	def self.get_option id
	  case id
		  when 1
		    'DNI'
		  when 2
		    'LC'
		  when 3
		    'LE'
		  when 4
		  	'PASPORTE'
		  when 5
		  	'CI'
		  when 6
		  	'CUIL'
		  when 7
		  	'CUIT'
		  when 8
		  	'OTRO'
		end
	end
end