class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])

    @location_contracts = @location.venues.map{|venue| venue.contracts}.flatten

    sorted_location_contracts = @location_contracts.sort_by{|contract| contract.opening_date}

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

    sorted_location_contracts.each do |contract|
      year = contract.opening_date.year.to_s
      category = contract.categories.first
      fees[category][year] == nil ? fees[category][year] = [] : true
      fees[category][year] << contract.fee
    end

    start_year = sorted_location_contracts.map{|con| con.opening_date.year}.min
    end_year = sorted_location_contracts.map{|con| con.opening_date.year}.max
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
    @chart = GoogleVisualr::Interactive::LineChart.new(data_table, option)
  end

end
