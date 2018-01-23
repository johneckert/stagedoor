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
      data_table.new_column('date', 'Year' )
      data_table.new_column('number', 'Scenic Design Fees')
      data_table.new_column('number', 'Costume Design Fees')
      data_table.new_column('number', 'Lighting Design Fees')
      data_table.new_column('number', 'Sound Design Fees')
      data_table.new_column('number', 'Projection Design Fees')

      sorted_contracts = ven.contracts.sort_by{|contract| contract.opening_date}
      sorted_contracts.each do |contract|
        case contract.categories.first.id
        when 1
          data_table.add_rows([[contract.opening_date, contract.fee, nil, nil, nil, nil]])
        when 2
          data_table.add_rows([[contract.opening_date, nil, contract.fee, nil, nil, nil]])
        when 3
          data_table.add_rows([[contract.opening_date, nil, nil, contract.fee, nil, nil]])
        when 4
          data_table.add_rows([[contract.opening_date, nil, nil, nil, contract.fee, nil]])
        when 5
          data_table.add_rows([[contract.opening_date, nil, nil, nil, nil, contract.fee]])
        else
          data_table.add_rows([[contract.opening_date, nil, nil, nil, nil, nil]])
        end
      end

      option = { width: 600, height: 240, title: 'Company Performance', trendlines: {
        0 => {type: 'polynomial', degree: 3}
        } }
      @charts[ven.id] = GoogleVisualr::Interactive::ScatterChart.new(data_table, option)
    end
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end
end
