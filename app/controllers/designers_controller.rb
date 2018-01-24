class DesignersController < ApplicationController
  skip_before_action :logged_in?, only: [:new, :create]


  def index
    @designers = Designer.all
    @all_chart = generate_all_designers_graph
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

  private

  def generate_all_designers_graph
    all_contracts = Designer.all.map{|designer| designer.contracts}.flatten
    sorted_contracts = all_contracts.sort_by{|contract| contract.opening_date}

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Year' )
    data_table.new_column('number', 'Scenic Design Fees')
    data_table.new_column('number', 'Costume Design Fees')
    data_table.new_column('number', 'Lighting Design Fees')
    data_table.new_column('number', 'Sound Design Fees')
    data_table.new_column('number', 'Projection Design Fees')

    scenic = Category.find(1)
    costume = Category.find(2)
    lighting = Category.find(3)
    sound = Category.find(4)
    projection = Category.find(5)

    fees = {
      scenic => {},
      costume => {},
      lighting => {},
      sound => {},
      projection => {}
    }

    sorted_contracts.each do |contract|
      year = contract.opening_date.year.to_s
      category = contract.categories.first
      fees[category][year] == nil ? fees[category][year] = [] : true
      fees[category][year] << contract.fee
    end

    start_year = sorted_contracts.map{|con| con.opening_date.year}.min
    end_year = sorted_contracts.map{|con| con.opening_date.year}.max
    i = start_year

    while i <= end_year do

      data_table.add_row(
        [
        i.to_s,
        avg(fees[scenic][i.to_s]),
        avg(fees[costume][i.to_s]),
        avg(fees[lighting][i.to_s]),
        avg(fees[sound][i.to_s]),
        avg(fees[projection][i.to_s])
      ])
      i +=1
    end unless i == nil

    option = { width: 1000, height: 240, title: 'Average Fees over Time'}
    GoogleVisualr::Interactive::LineChart.new(data_table, option)
  end



end
