class SessionsController < ApplicationController
  skip_before_action :logged_in?

  def create
    @designer = Designer.find_by(username: params[:username])
    if @designer && @designer.authenticate(params[:password])
      session[:designer_id] = @designer.id
    else
      flash[:error] = ["Incorrect login."]
    end
    buybug
    redirect_to root_path
  end

  def destroy
    session.delete :designer_id
    redirect_to root_path
  end

end
