class CompaniesController < ApplicationController

  def show
    @company = Company.find(params[:id])
    @venues = @company.venues
    data_table = GoogleVisualr::DataTable.new
      fee_by_year = {}
    @venues.contracts.each do |c|
      year = c.opening_date.split("-").first
      fee = 
    # Add Column Headers
    data_table.new_column('string', 'Date' )
    data_table.new_column('number', 'Fee')
    # @venues.each do |venue|
    #   venue.contracts.each do |contract|
    #     data_table.add_rows([contract.opening_date, contract.fee])
    #   end
    # end

    data_table.add_rows([
    	['2004', 1000],
    	['2005', 1170],
    	['2006', 660],
    	['2007', 1030]
    ])

    option = { width: 600, height: 240, title: 'Company Performance' }
    @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)

  end



  private

  def company_params
    params.require(:company).permit(:name)
  end
end
