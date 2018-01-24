class DesignersController < ApplicationController
  skip_before_action :logged_in?, only: [:new, :create]


  def index
    @designers = Designer.all
    @all_chart = generate_all_graph(Designer)
    @gender_scenic_chart = generate_stat_graph(Category.find(1), "gender", Designer)
    @gender_costume_chart = generate_stat_graph(Category.find(2), "gender", Designer)
    @gender_lighting_chart = generate_stat_graph(Category.find(3), "gender", Designer)
    @gender_sound_chart = generate_stat_graph(Category.find(4), "gender", Designer)
    @gender_projection_chart = generate_stat_graph(Category.find(5), "gender", Designer)
    @ethnicity_scenic_chart = generate_stat_graph(Category.find(1), "ethnicity", Designer)
    @ethnicity_costume_chart = generate_stat_graph(Category.find(2), "ethnicity", Designer)
    @ethnicity_lighting_chart = generate_stat_graph(Category.find(3), "ethnicity", Designer)
    @ethnicity_sound_chart = generate_stat_graph(Category.find(4), "ethnicity", Designer)
    @ethnicity_projection_chart = generate_stat_graph(Category.find(5), "ethnicity", Designer)
  end

  def new
    @designer = Designer.new
  end

  def create
    byebug
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
    params.require(:designer).permit(:username, :gender, :birth_year, :password, :password_confirmation, ethnicity: [])
  end

end
