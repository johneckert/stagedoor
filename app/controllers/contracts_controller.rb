class ContractsController < ApplicationController

  def new
    @contract = Contract.new
  end

  def show
  end

  private

  def contract_params
    params.require(:contract).permit(:venue_id, :designer_id, :type, :opening_date, :musical, :fee, :category_ids)
  end
end
