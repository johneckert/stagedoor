class CompaniesController < ApplicationController

  def show
    @company = Company.find(params[:id])
    @venues = @company.venues
    @charts = {}

    @venues.each do |ven|
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('date', 'Year' )
      data_table.new_column('number', 'Scenic Design Fees')
      data_table.new_column('number', 'Costume Design Fees')
      data_table.new_column('number', 'Lighting Design Fees')
      data_table.new_column('number', 'Sound Design Fees')
      data_table.new_column('number', 'Projection Design Fees')

      fees = {
        Category.find(1) => {},
        Category.find(2) => {},
        Category.find(3) => {},
        Category.find(4) => {},
        Category.find(5) => {}
      }

      ven.contracts.each do |contract|
        year = contract.opening_date.year
        category = contract.categories.first
        fees[category][year] == nil ? fees[category][year] : true


      data_table.add_rows([[contract.opening_date, contract.fee, nil, nil, nil, nil]])


      option = { width: 600, height: 240, title: 'Company Performance'}
      @charts[ven.id] = GoogleVisualr::Interactive::ScatterChart.new(data_table, option)
    end
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end
end
