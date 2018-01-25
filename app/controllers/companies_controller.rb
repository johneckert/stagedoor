class CompaniesController < ApplicationController
  before_action :logged_in?

  def index
    if params[:search]
      @query = params[:search]
      query = "%" + params[:search] + "%"
      @companies = Company.where(["name LIKE ?", query])
    else
      @companies = Company.all
    end
  end

  def show
    @company = Company.find(params[:id])
    @venues = @company.venues
    @all_charts = {}
    @gender_scenic_charts = {}
    @gender_costume_charts = {}
    @gender_lighting_charts = {}
    @gender_sound_charts = {}
    @gender_projection_charts = {}
    @ethnicity_scenic_charts = {}
    @ethnicity_costume_charts = {}
    @ethnicity_lighting_charts = {}
    @ethnicity_sound_charts = {}
    @ethnicity_projection_charts = {}
    @venues.each do |ven|
      @all_charts[ven.id] = generate_all_graph(ven.contracts)
      @gender_scenic_charts[ven.id] = generate_stat_graph(Category.find(1), "gender", ven.contracts)
      @gender_costume_charts[ven.id] = generate_stat_graph(Category.find(2), "gender", ven.contracts)
      @gender_lighting_charts[ven.id] = generate_stat_graph(Category.find(3), "gender", ven.contracts)
      @gender_sound_charts[ven.id] = generate_stat_graph(Category.find(4), "gender", ven.contracts)
      @gender_projection_charts[ven.id] = generate_stat_graph(Category.find(5), "gender", ven.contracts)
      @ethnicity_scenic_charts[ven.id] = generate_stat_graph(Category.find(1), "ethnicity", ven.contracts)
      @ethnicity_costume_charts[ven.id] = generate_stat_graph(Category.find(2), "ethnicity", ven.contracts)
      @ethnicity_lighting_charts[ven.id] = generate_stat_graph(Category.find(3), "ethnicity", ven.contracts)
      @ethnicity_sound_charts[ven.id] = generate_stat_graph(Category.find(4), "ethnicity", ven.contracts)
      @ethnicity_projection_charts[ven.id] = generate_stat_graph(Category.find(5), "ethnicity", ven.contracts)
    end
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end

end
