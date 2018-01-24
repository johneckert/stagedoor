class DesignersController < ApplicationController
  skip_before_action :logged_in?, only: [:new, :create]


  def index
    @designers = Designer.all
    @all_chart = generate_all_designers_graph
    @gender_scenic_chart = generate_gender_graph(Category.find(1), "gender")
    @gender_costume_chart = generate_gender_graph(Category.find(2), "gender")
    @gender_lighting_chart = generate_gender_graph(Category.find(3), "gender")
    @gender_sound_chart = generate_gender_graph(Category.find(4), "gender")
    @gender_projection_chart = generate_gender_graph(Category.find(5), "gender")
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

  def generate_gender_graph(category, stat)
    all_contracts = Designer.all.map{|designer| designer.contracts}.flatten
    selected_contracts = all_contracts.select{|contract| contract.categories.first == category}
    sorted_contracts = selected_contracts.sort_by{|contract| contract.opening_date}

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Year' )

    if stat == "gender"
      data_table.new_column('number', "#{category.name} Fees, Male")
      data_table.new_column('number', "#{category.name} Fees, Female")

      male_category = category.name + "Male"
      female_category = category.name + "Female"

      fees = {
        male_category => {},
        female_category => {}
      }

    elsif stat == "ethnicity"
      data_table.new_column('number', "#{category.name} Fees, Asian/Indian subcontinent")
      data_table.new_column('number', "#{category.name} Fees, Black")
      data_table.new_column('number', "#{category.name} Fees, Hispanic")
      data_table.new_column('number', "#{category.name} Fees, Native American")
      data_table.new_column('number', "#{category.name} Fees, Pacific Islander")
      data_table.new_column('number', "#{category.name} Fees, White")
      data_table.new_column('number', "#{category.name} Fees, Other")

      asian_category = category.name + "Asian/Indian subcontinent"
      black_category = category.name + "Black"
      hispanic_category = category.name + "Hispanic"
      native_category = category.name + "Native American"
      pacific_category = category.name + "Pacific Islander"
      white_category = category.name + "White"
      other_category = category.name + "Other"

      fees = {
        asian_category => {},
        black_category => {},
        hispanic_category => {},
        native_category => {},
        pacific_category => {},
        white_category => {},
        other_category => {}
        }
    end

    sorted_contracts.each do |contract|
      year = contract.opening_date.year.to_s
      if stat == "gender"
        key = category.name + contract.designer.gender
      elsif stat == "ethnicity"
        key = category.name + contract.designer.ethnicity
      end
      fees[key][year] == nil ? fees[key][year] = [] : true
      fees[key][year] << contract.fee
    end

    start_year = sorted_contracts.map{|con| con.opening_date.year}.min
    end_year = sorted_contracts.map{|con| con.opening_date.year}.max
    year = start_year

    while year <= end_year do
      row = [year.to_s]
      fees.each do |stat_category|
        row << avg(fees[stat_category[0]][year.to_s])
      end
      data_table.add_row(row)
      year +=1
    end unless year == nil

    option = { width: 1000, height: 240, title: "Average #{category.name} Fees over Time"}
    GoogleVisualr::Interactive::LineChart.new(data_table, option)
  end

  def generate_ethnicity_graph

  end

  def generate_age_graph
  end

  def avg(num_array)
    if num_array == nil
      return 0
    else
      num_array.inject(:+) / num_array.count
    end
  end

end
