class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :logged_in?, except: :index

  def index
    @companies = Company.all
    @locations = Location.all
  end

  def current_user
    session[:designer_id] ? Designer.find(session[:designer_id]) : nil
  end

  def analytics_select
    if params[:company] != nil
      redirect_to company_path(params[:company])
    else
      redirect_to location_path(params[:location])
    end
  end

  private

  def logged_in?
    current_user ? true : redirect_to(login_path)
  end

end
