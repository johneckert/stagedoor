class DesignersController < ApplicationController
  skip_before_action :logged_in?, only: [:create]


  def index
    @designers = Designer.all
    designer_contracts = Designer.all.map{|designer| designer.contracts}.flatten
    @all_chart = generate_all_graph(designer_contracts)
    @gender_scenic_chart = generate_stat_graph(Category.find(1), "gender", designer_contracts)
    @gender_costume_chart = generate_stat_graph(Category.find(2), "gender", designer_contracts)
    @gender_lighting_chart = generate_stat_graph(Category.find(3), "gender", designer_contracts)
    @gender_sound_chart = generate_stat_graph(Category.find(4), "gender", designer_contracts)
    @gender_projection_chart = generate_stat_graph(Category.find(5), "gender", designer_contracts)
    @ethnicity_scenic_chart = generate_stat_graph(Category.find(1), "ethnicity", designer_contracts)
    @ethnicity_costume_chart = generate_stat_graph(Category.find(2), "ethnicity", designer_contracts)
    @ethnicity_lighting_chart = generate_stat_graph(Category.find(3), "ethnicity", designer_contracts)
    @ethnicity_sound_chart = generate_stat_graph(Category.find(4), "ethnicity", designer_contracts)
    @ethnicity_projection_chart = generate_stat_graph(Category.find(5), "ethnicity", designer_contracts)
  end

  def create
    maybe_designer = Designer.new(designer_params)
    designer_check = maybe_designer.save
    if designer_check
      @designer = Designer.last
      session[:designer_id] = @designer.id
    else
      flash[:error] = maybe_designer.errors.full_messages
    end
    redirect_to root_path
  end

  def designer_params
    params.require(:designer).permit(:username, :gender, :birth_year, :password, :password_confirmation, :ethnicity)
  end

end
