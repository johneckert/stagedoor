class LocationsController < ApplicationController
  before_action :logged_in?

  def show
    @location = Location.find(params[:id])
    @location_contracts = @location.venues.map{|venue| venue.contracts}.flatten
    @all_chart = generate_all_graph(@location_contracts)
    @gender_scenic_chart = generate_stat_graph(Category.find(1), "gender", @location_contracts)
    @gender_costume_chart = generate_stat_graph(Category.find(2), "gender", @location_contracts)
    @gender_lighting_chart = generate_stat_graph(Category.find(3), "gender", @location_contracts)
    @gender_sound_chart = generate_stat_graph(Category.find(4), "gender", @location_contracts)
    @gender_projection_chart = generate_stat_graph(Category.find(5), "gender", @location_contracts)
    @ethnicity_scenic_chart = generate_stat_graph(Category.find(1), "ethnicity", @location_contracts)
    @ethnicity_costume_chart = generate_stat_graph(Category.find(2), "ethnicity", @location_contracts)
    @ethnicity_lighting_chart = generate_stat_graph(Category.find(3), "ethnicity", @location_contracts)
    @ethnicity_sound_chart = generate_stat_graph(Category.find(4), "ethnicity", @location_contracts)
    @ethnicity_projection_chart = generate_stat_graph(Category.find(5), "ethnicity", @location_contracts)
  end

end
