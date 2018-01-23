class CompaniesController < ApplicationController

  def show
    @company = Company.find(params[:id])
    @venues = @company.venues
    data_table = GoogleVisualr::DataTable.new
  end



  private

  def company_params
    params.require(:company).permit(:name)
  end
end
