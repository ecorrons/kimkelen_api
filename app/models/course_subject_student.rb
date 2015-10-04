class CourseSubjectStudent < ActiveRecord::Base
	  self.table_name = "course_subject_student"

	  has_one 		:course, through: :course_subject
	  has_many 		:course_subject_student_marks
	  has_many 		:course_subject_student_examinations
	  has_many 		:student_repproved_course_subjects
	  has_many		:student_examination_repproved_subjects, through: :student_repproved_course_subjects
	  belongs_to  :student
	  belongs_to  :course_subject
	  has_one			:career_subject_school_year, through: :course_subject

	  def to_builder
	    Jbuilder.new do |cs|
	      cs.name course.name
	      cs.average  average
	      cs.marks course_subject_student_marks.map {|cssm| cssm.to_builder.attributes!}
	      cs.examinations course_subject_student_examinations.map {|csse| csse.to_builder.attributes!}
	      cs.repproveds student_examination_repproved_subjects.map {|sers| sers.to_builder.attributes!}
	      cs.final_average final_average
	    end
  	end

  	def final_average
  		sacs = StudentApprovedCareerSubject.find_by(student: student, school_year_id: course.school_year_id, career_subject_id:  career_subject_school_year.career_subject_id)
  		sacs.mark unless sacs.nil?
  	end

  	def average
  		unless course_subject_student_marks.detect {|x| x.mark.nil? }
  			total = course_subject_student_marks.inject(0) {|total, x| total + x.mark.to_f }
  			resul = (total / course_subject_student_marks.size).round(2)
  			resul
			end
  	end
end

