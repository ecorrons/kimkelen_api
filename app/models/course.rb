class Course < ActiveRecord::Base
  self.table_name = "course"

  has_many   :course_subjects
  belongs_to :school_year
end
