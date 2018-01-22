class SessionsController < ApplicationController

  def new
  end

  def create
    @designer = Designer.find_by(username: params[:designer][:username])
    byebug
    if @designer && @designer.authenticate(params[:designer][:password])
      session[:designer_id] = @designer.id
      redirect_to root_path
    else
      flash[:error] = ["incorrect login, try again"]
      redirect_to login_path
    end
  end

  def destroy
    session.delete :designer_id
    redirect_to root_path
  end
end
