class TeachersController < ApplicationController
  before_action :authenticate_teacher, only: [:dashboard]

  def index
  end

  def login
    username = params[:username]
    password = params[:password]
    teacher = Teacher.find_by(username: username, password: password)
    if teacher
      session[:teacher_id] = teacher.id
      redirect_to '/dashboard', notice: 'Logged in successfully!'
    else
      flash[:alert] = 'Invalid username or password'
      redirect_to '/'
    end
  end

  def dashboard
    @students = Student.all
    @student = Student.new
  end

  def logout
    session[:teacher_id] = nil
    redirect_to '/', notice: 'Logged out successfully!'
  end
end