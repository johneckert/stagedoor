class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :logged_in?
  skip_before_action :logged_in?, only: :index

  def index
  end

  def current_user
    session[:designer_id]? Designer.find(session[:designer_id]) : nil
  end

  def logged_in?
    current_user ? true : redirect_to(login_path)
  end

end
