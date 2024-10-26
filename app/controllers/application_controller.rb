class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_teacher

  def current_teacher
    @current_teacher ||= Teacher.find_by(id: session[:teacher_id]) if session[:teacher_id]
  end

  def authenticate_teacher
    redirect_to '/' unless current_teacher
  end
end
