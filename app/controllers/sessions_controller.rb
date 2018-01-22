class SessionsController < ApplicationController

  def new
  end

  def create
    @designer = Designer.find_by(username: params[:designer][:username])
    if @designer && @designer.authenticate(params[:user][:password])
      session[:designer_id] = @designer.id
      redirect_to designer_path
    else
      flash[:error] = ["incorrect login, try again"]
      redirect_to login_path
    end
  end

  def destroy
    session.delete :designer_id
    redirect_to
  end
end
