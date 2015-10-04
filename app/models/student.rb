class Student < ActiveRecord::Base
	self.table_name = "student"

	MIN_AVERAGE = 7

	belongs_to :person
	has_many :student_tutors
	has_many :tutors, through: :student_tutors
	has_many :student_career_school_years
	has_many :course_subject_students
	has_many :student_approved_career_subjects
	has_many :student_attendances
	has_many :disciplinary_sanctions
	has_many :school_year_students

	def image_path
		"#{self.self_path}/image"
	end

	def self_path
		"/students/#{self.id}"
	end

	def to_builder
    Jbuilder.new do |student|
      student.id id
      student.global_file_number global_file_number
      student.person person.to_builder
      student._links _links(image_path)
    end
	end

	def to_builder_for_tutor
		Jbuilder.new do |student|
			student.id id
			student.name "#{person.firstname}, #{person.lastname}"
			student._links(self_path)
		end
	end

	def marks_to_builder(school_year)
  	career_school_year = CareerSchoolYear.find_by(school_year: school_year)
 		@student_career_school_year = StudentCareerSchoolYear.find_by(student: self, career_school_year: career_school_year)
		Jbuilder.new do |student|
			student.school_year school_year.year
			student.year @student_career_school_year.year
			student.status StudentStatus::get_option @student_career_school_year.status
			student.course_subjects course_subjects_students_for(school_year).map { |css| css.to_builder.attributes! }
			student.global_average global_average(school_year)
		end
	end

	def course_subjects_students_for(school_year)
		course_subject_students.joins(:course_subject).joins(:course).where("course.school_year_id = ?", school_year.id)
	end

	def global_average(school_year)
		total_student_approved_career_subjects = student_approved_career_subjects.where(school_year_id: school_year.id)
		sum = total_student_approved_career_subjects.inject(0) {|total, x| total + x.mark }
		unless sum.zero?
			avg = (sum / total_student_approved_career_subjects.size).round(2)
			avg if avg >= MIN_AVERAGE
		end
	end

	def absences_for_year(school_year)
		student_attendances.absences.joins(:career_school_year).where("career_school_year.school_year_id = ?", school_year.id)
	end

	def absences_to_builder(school_year)
		Jbuilder.new do |student_attendance|
			student_attendance.school_year school_year.year
			student_attendance.absences absences_for_year(school_year).map {|sa| sa.to_builder.attributes!}
			student_attendance.total_absences total_absences(school_year)
		end
	end

	def total_absences(school_year)
		absences_for_year(school_year).size
	end

	def total_disciplinary_sanctions(school_year)
		disciplinary_sanctions.where(school_year_id: school_year.id).size
	end

	def disciplinary_sanctions_to_builder(school_year)
		Jbuilder.new do |sanctions|
			sanctions.school_year school_year.year
			sanctions.disciplinary_sanctions disciplinary_sanctions.where(school_year_id: school_year.id).map {|ds| ds.to_builder.attributes!}
			#anctions.disciplinary_sanctions disciplinary_sanctions.where("student_advice.school_year_id = ?", school_year.id).map {|ds| ds.to_builder.attributes!}
			sanctions.total_disciplinary_sanctions total_disciplinary_sanctions(school_year)
		end
	end

	def school_years_to_builder
		school_year_students.map {|sys| sys.school_year.to_builder.attributes!}
	end

	private

  	def _links(path)
  		[ref: 'self', href: path, method: 'GET']
  	end
end

