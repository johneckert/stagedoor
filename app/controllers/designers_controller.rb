class DesignersController < ApplicationController

  def new
    @designer = Designer.new
  end

  def create
    designer_check = Designer.new(designer_params).save
    if designer_check
      @designer = Designer.last
      session[:designer_id] = @designer.id
      redirect_to root_path
    else
      redirect_to new_designer_path
    end
  end

  def designer_params
    params.require(:designer).permit(:username, :gender, :ethnicity, :birth_year, :password, :password_confirmation)
  end

end
