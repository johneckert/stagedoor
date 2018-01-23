class CompaniesController < ApplicationController

  def show
    @company = Company.find(params[:id])
    @venues = @company.venues
  end



  private

  def company_params
    params.require(:company).permit(:name)
  end
end
