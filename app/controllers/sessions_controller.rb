class SessionsController < ApplicationController
  skip_before_action :logged_in?
  before_action :logged_out?, only: :new

  def new
  end

  def create
    @designer = Designer.find_by(username: params[:username])
    if @designer && @designer.authenticate(params[:password])
      session[:designer_id] = @designer.id
      redirect_to root_path
    else
      flash[:error] = ["Incorrect login."]
      redirect_to login_path
    end
  end

  def destroy
    session.delete :designer_id
    redirect_to root_path
  end

  private

  def logged_out?
    current_user ? redirect_to(root_path) : true
  end
end
