class CompaniesController < ApplicationController

  def show
    @company = Company.find(params[:id])
    @venues = @company.venues
    data_table = GoogleVisualr::DataTable.new
    # Add Column Headers
    data_table.new_column('string', 'Year' )
    data_table.new_column('number', 'Sales')
    data_table.new_column('number', 'Expenses')

    # Add Rows and Values
    data_table.add_rows([
    	['2004', 1000, 400],
    	['2005', 1170, 460],
    	['2006', 660, 1120],
    	['2007', 1030, 540]
    ])

    option = { width: 600, height: 240, title: 'Company Performance' }
    @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)

  end



  private

  def company_params
    params.require(:company).permit(:name)
  end
end
