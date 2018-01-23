class ContractsController < ApplicationController

  def new
    @contract = Contract.new
    @venues = Venue.all
    @companies = Company.all
  end

  def create
    # byebug
    @contract = Contract.new(contract_params)
    if @contract.valid?
      @contract.save
      @contract.user = current_user
      redirect_to root_path
    else
      flash[:error]
      render :new
    end
  end

  def show
  end

  private

  def contract_params
    params.require(:contract).permit(:venue_id, :show_name, :opening_date, :musical, :fee, :category_ids, :company_id)
  end
end
