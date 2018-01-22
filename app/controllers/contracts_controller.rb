class ContractsController < ApplicationController

  def new
    @contract = Contract.new
    @venues = Venue.all
  end

  def create
    @contract = Contract.new(contract_params)
    if @contract.valid?
      @contract.save
      @contract.user = current_user
    else
      flash[:error]
      render :new
    end
  end

  def show
  end

  private

  def contract_params
    params.require(:contract).permit(:venue_id, :type, :opening_date, :musical, :fee, :category_ids)
  end
end
