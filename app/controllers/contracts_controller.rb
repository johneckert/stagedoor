class ContractsController < ApplicationController
  before_action

  def index
    data_table_a = GoogleVisualr::DataTable.new
    data_table_b = GoogleVisualr::DataTable.new
    data_table_c = GoogleVisualr::DataTable.new
    contract_type = Hash.new(0)
    fees_by_date = Hash.new
    category = Hash.new(0)

    current_user.contracts.map do |con|
      contract_type[con.venue.contract_type] += 1
      fees_by_date[con.opening_date] = con.fee
      con.categories.each do |cat|
        category[cat.name] += 1
      end
    end

    #bar chart of category type
    data_table_a.new_column('string', 'Category')
    data_table_a.new_column('number', 'Number of Contracts')
    data_table_a.add_rows(category.keys.count)
    category.each do |h|
      data_table_a.add_rows([h])
    end
    opts_a   = { :width => 600, :height => 360, :title => 'Category Breakdown', :is3D => true}
    @barchart = GoogleVisualr::Interactive::BarChart.new(data_table_a, opts_a)


    #pie chart of contract type
    data_table_b.new_column('string', 'Contract Type')
    data_table_b.new_column('number', 'Number of Contracts')
    data_table_b.add_rows(contract_type.keys.count)
    contract_type.each do |h|
      data_table_b.add_rows([h])
    end
    opts_b   = { :width => 600, :height => 360, :title => 'Contract Overview', :is3D => true }
    @piechart = GoogleVisualr::Interactive::PieChart.new(data_table_b, opts_b)

    #line chart of fee over time
    data_table_c = GoogleVisualr::DataTable.new
    data_table_c.new_column('date', 'Date' )
    data_table_c.new_column('number', 'Fee')

    sorted_fees = fees_by_date.sort
    sorted_fees.each do |k,v|
      data_table_c.add_rows([[k, v]])
    end

    option_c = { width: 600, height: 240, title: 'Fee History' }
    @feechart = GoogleVisualr::Interactive::AreaChart.new(data_table_c, option_c)

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
    @categories = Category.all
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
