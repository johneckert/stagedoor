class ContractsController < ApplicationController

  def index
    data_table = GoogleVisualr::DataTable.new
    contract_type = Hash.new(0)
    fees_by_date = Hash.new
    current_user.contracts.map do |con|
      contract_type[con.venue.contract_type] += 1
      fees_by_date[con.opening_date] = con.fee
    end

    #pie chart of contract type
    data_table.new_column('string', 'Contract Type')
    data_table.new_column('number', 'Number of Contracts')
    data_table.add_rows(contract_type.keys.count)
    contract_type.each do |h|
      data_table.add_rows([h])
    end
    opts   = { :width => 400, :height => 240, :title => 'My Daily Activities', :is3D => true }
    @piechart = GoogleVisualr::Interactive::PieChart.new(data_table, opts)

    #line chart of fee over time
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Date' )
    data_table.new_column('number', 'Fee')

    sorted_fees = fees_by_date.sort
    sorted_fees.each do |k,v|
      data_table.add_rows([[k, v]])
    end

    option = { width: 600, height: 240, title: 'Company Performance' }
    @feechart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)

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

  def edit
    @contract = Contract.find(params[:id])
    @venues = Venue.all
    @companies = Company.all
    @categories = Category.all
  end

  def update
    @contract = Contract.find(params[:id])
    @contract.update(contract_params)
    if @contract.valid?
      redirect_to contracts_path
    else
      redirect_to edit_contract_path(@contract)
    end
  end

  private

  def contract_params
    params.require(:contract).permit(:venue_id, :show_name, :opening_date, :musical, :fee, :company_id, category_ids: [])
  end
end
