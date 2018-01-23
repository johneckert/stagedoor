class ContractsController < ApplicationController

  def index
    data_table = GoogleVisualr::DataTable.new
    con_type_hash = Hash.new(0)
    current_user.contracts.map do |con|
      con_type_hash[con.venue.contract_type] += 1
    end

    data_table.new_column('string', 'Contract Type')
    data_table.new_column('number', 'Number of Contracts')
    data_table.add_rows(con_type_hash.keys.count)
    con_type_hash.each do |h|
      data_table.add_rows([h])
    end

    opts   = { :width => 400, :height => 240, :title => 'My Daily Activities', :is3D => true }
    @piechart = GoogleVisualr::Interactive::PieChart.new(data_table, opts)
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
