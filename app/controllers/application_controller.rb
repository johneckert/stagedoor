class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def index
  end

  def current_user
    session[:designer_id]
  end
end
