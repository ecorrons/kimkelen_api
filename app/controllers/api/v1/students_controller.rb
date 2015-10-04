class Api::V1::StudentsController < Api::V1::ApiController

  before_action :set_student, only: [:show, :marks, :absences, :disciplinary_sanctions, :school_years]
  before_action :set_person, only: [:show]
  before_action :set_school_year, only: [:marks, :absences, :disciplinary_sanctions]

  def show
    # consulta: http://localhost:3000/api/v1/students/3
    render json: {error: I18n.t("errors.messages.student.invalid"), status: 404}, status: :not_found if @student.nil?
  end

  def marks
    # consulta: http://localhost:3000/api/v1/students/5/marks/2011 -> exitosa
    # consulta: http://localhost:3000/api/v1/students/487/marks/2012 -> desaprobado
    return render json: { error: I18n.t("errors.messages.school_year.invalid"), status: 404 }, status: :not_found if @school_year.nil?
    
    return render json: { error: I18n.t("errors.messages.student.invalid"), status: 404 }, status: :not_found if @student.nil?
   
    return render json: { error: I18n.t("errors.messages.student.invalid_school_year"), status: 500 }, status: :server_error unless @student.school_year_students.map(&:school_year).include? @school_year

  end

  def absences
    # consulta: http://localhost:3000/api/v1/students/975/absences/2012
    return render json: { error: I18n.t("errors.messages.school_year.invalid"), status: 404 }, status: :not_found if @school_year.nil?
    return render json: { error: I18n.t("errors.messages.student.invalid"), status: 404 }, status: :not_found if @student.nil?
  end

  def disciplinary_sanctions
    # consulta: http://localhost:3000/api/v1/students/677/disciplinary_sanctions/2011
    return render json: { error: I18n.t("errors.messages.school_year.invalid"), status: 404 }, status: :not_found if @school_year.nil?
    return render json: { error: I18n.t("errors.messages.student.invalid"), status: 404 }, status: :not_found if @student.nil?
  end

  def school_years
    render json: { error: I18n.t("errors.messages.student.invalid"), status: 404 }, status: :not_found if @student.nil?
  end


  private
    def set_student
      @student = Student.find_by(id: params[:id])
    end

    def set_person
      @person = Person.find(@student.person_id) if @student
    end

    def set_school_year
      @school_year = SchoolYear.find_by(year: params[:school_year])
    end
end