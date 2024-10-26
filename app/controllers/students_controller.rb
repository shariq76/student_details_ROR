class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @students = Student.all
  end

  # GET /students/1 or /students/1.json
  def show
  end

  def add
    @student = Student.find_by(name: student_params[:name], subject: student_params[:subject])
    if @student
      # If student exists, update the mark
      if @student.update(mark: student_params[:mark])
        redirect_to dashboard_path, notice: "Student's mark was successfully updated."
      else
        flash[:alert] = "Failed to update the student's mark."
        redirect_to dashboard_path
      end
    else
      # If student does not exist, create a new student record
      @student = Student.new(student_params)
      if @student.save
        redirect_to dashboard_path, notice: "Student was successfully added."
      else
        flash[:alert] = "Failed to add student."
        redirect_to dashboard_path
      end
    end
  end

  def editStudent
    @student = Student.find(params[:id]) # Find the existing student by id
    name = params['edit_name']
    subject = params['edit_subject']
    mark = params['edit_mark']
    if @student
      @student.update(name: name, subject: subject, mark: mark)
      redirect_to dashboard_path
    else
      puts 'Didnt get'
      redirect_to dashboard_path
    end
  end

  def deleteStudent
    @student = Student.find(params[:id])
    @student.destroy!
    redirect_to dashboard_path
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy!

    respond_to do |format|
      format.html { redirect_to students_path, status: :see_other, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:name, :subject, :mark)
    end
end
