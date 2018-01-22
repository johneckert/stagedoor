class DesignersController < ApplicationController

  def new
    @designer = Designer.new
  end

  def create
    byebug
    designer_check = Designer.new(designer_params).save
    if designer_check
      @designer = Designer.last
      session[:designer_id] = @designer.id
      redirect_to root
    else
      redirect_to new_designer_path
    end
  end

end
