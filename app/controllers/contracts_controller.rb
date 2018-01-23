class ContractsController < ApplicationController


  def index
  end

  def new
    @contract = Contract.new
    @venues = Venue.all
    @companies = Company.all
    @categories = Category.all
  end

  def create
    @venues = Venue.all
    @companies = Company.all
    @contract = Contract.new(contract_params)
    @contract.designer = current_user
    if @contract.valid?
      @contract.save
      redirect_to root_path
    else
      flash[:error] = @contract.errors.full_messages
      render :new
    end
  end

  private

  def contract_params
    params.require(:contract).permit(:venue_id, :show_name, :opening_date, :musical, :fee, :category_ids, :company_id)
  end
end
