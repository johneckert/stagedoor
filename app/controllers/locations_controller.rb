class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @venues = @location.venues
    @charts = {}
    @venues.each do |ven|
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Year' )
      data_table.new_column('number', 'Fee')

      sorted_contracts = ven.contracts.sort_by{|contract| contract.opening_date}
      sorted_contracts.each do |contract|
        data_table.add_rows([[contract.opening_date.year.to_s, contract.fee]])
      end

      option = { width: 600, height: 240, title: 'Company Performance' }
      @charts[ven.id] = GoogleVisualr::Interactive::AreaChart.new(data_table, option)
    end
  end
end
