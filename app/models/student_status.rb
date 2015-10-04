class StudentStatus 

	def self.get_option id
	  case id
		  when 0
		    'Cursando'
		  when 1
		    'Aprobado'
		  when 2
		    'Repitio este año'
		  when 3
		  	'Repetidor del año pasado, pero cursando año lectivo actual'
		  when 4
		  	'Retirado de la institución'
			end
	end
end
