class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    @venues = @company.venues
    @charts = {}

    @venues.each do |ven|
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

      ven.contracts.each do |contract|
        year = contract.opening_date.year.to_s
        category = contract.categories.first
        fees[category][year] == nil ? fees[category][year] = [] : true
        fees[category][year] << contract.fee
      end

      start_year = ven.contracts.map{|con| con.opening_date.year}.min
      end_year = ven.contracts.map{|con| con.opening_date.year}.max
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

      option = { width: 600, height: 240, title: 'Company Performance'}
      @charts[ven.id] = GoogleVisualr::Interactive::LineChart.new(data_table, option)
    end
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end

  def avg(num_array)
    if num_array == nil
      return 0
    else
      num_array.inject(:+) / num_array.count
    end
  end
end
